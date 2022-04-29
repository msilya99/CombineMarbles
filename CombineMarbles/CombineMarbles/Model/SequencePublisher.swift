//
//  SequencePublisher.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import Foundation
import Combine

///Here are the details of the lifecycle of a subscription:
/// 1. A subscriber subscribes to the publisher.
/// 2. The publisher creates a Subscription then hands it over to the subscriber (calling receive(subscription:)).
/// 3. The subscriber requests values from the subscription by sending it the number of values it wants (calling the subscription’s request(_:) method).
/// 4. The subscription begins the work and starts emitting values. It sends them one by one to the subscriber (calling the subscriber’s receive(_:) method).
/// 5. Upon receiving a value, the subscriber returns a new Subscribers.Demand, which adds to the previous total demand.
/// 6. The subscription keeps sending values until the number of values sent reaches the total requested number.

struct FailureString: Error, Equatable {
    let content: String
}

struct SequencePublisher: Publisher {
    typealias Output = String
    typealias Failure = FailureString

    private let events: [TimedEvent]
    private let scheduler: SequenceScheduler

    init(events: [TimedEvent], scheduler: SequenceScheduler) {
        self.events = events
        self.scheduler = scheduler
    }

    func receive<Sub>(subscriber: Sub) where Sub : Subscriber, Failure == Sub.Failure, Sub.Input == Output {
        let subscription = SequenceSubscription<Sub>(events: events, subscriber: subscriber, scheduler: scheduler)
        subscriber.receive(subscription: subscription)
    }
}


fileprivate class SequenceSubscription<S>: Subscription where S : Subscriber,
                                                              FailureString == S.Failure,
                                                              S.Input == String {
    // MARK: - variables

    var subscriber: S?
    let scheduler: SequenceScheduler
    let events: [TimedEvent]
    var emitted: Int = 0

    // MARK: - initialization

    init(events: [TimedEvent], subscriber: S, scheduler: SequenceScheduler) {
        self.events = events
        self.subscriber = subscriber
        self.scheduler = scheduler
    }

    // MARK: - actions

    func cancel() {
        subscriber = nil
    }

    func request(_ demand: Subscribers.Demand) {
        if let last = events.last, scheduler.now.distance(to: .milliseconds(last.timeInterval)) < 0 {
            subscriber?.receive(completion: .finished)
            return
        }

        let requested = demand.max.map { emitted + $0 } ?? events.count
        guard requested <= events.count else { return }

        events[emitted..<requested].forEach { event in
            self.scheduler.schedule(after: .milliseconds(event.timeInterval)) { [weak self] in
                switch event.type {
                case .next:
                    _ = self?.subscriber?.receive(event.content!)
                case .finished:
                    self?.subscriber?.receive(completion: .finished)
                case .error:
                    self?.subscriber?.receive(completion: .failure(FailureString(content: "")))
                }
            }
        }

        emitted = requested
    }
}
