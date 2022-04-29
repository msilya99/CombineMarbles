//
//  MarbleViewState.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 28.04.22.
//

import Foundation
import Combine

typealias InitialState = (input: [[TimedEvent]], generator: ([SequencePublisher], SequenceScheduler) -> SequenceExperimentRunner)

class MarbleViewState: ObservableObject {

    // MARK: - variables

    @Published var input: [[TimedEvent]] {
        didSet { update() }
    }

    @Published var output: [TimedEvent] = []

    private let initionalState: InitialState

    private var generator: ([SequencePublisher], SequenceScheduler) -> SequenceExperimentRunner
    private var cancellable = Set<AnyCancellable>()

    // MARK: - initialization

    init(input: [[TimedEvent]], generator: @escaping ([SequencePublisher], SequenceScheduler) -> SequenceExperimentRunner) {
        self.input = input
        self.generator = generator
        self.initionalState = (input, generator)
    }

    // MARK: - actions

    /// was RunLoop.main but now DispatchQueue.main because of
    /// https://www.avanderlee.com/combine/runloop-main-vs-dispatchqueue-main/
    func update() {
        let scheduler = SequenceScheduler()
        generator(self.input.map { SequencePublisher(events: $0, scheduler: scheduler) }, scheduler)
            .run(scheduler: scheduler)
            .receive(on: DispatchQueue.main)
            .assign(to: \.output, on: self)
            .store(in: &cancellable)
    }

    func resetToInitionalState() {
        input = initionalState.input
        generator = initionalState.generator
    }
}

extension TupleOperator {
    var state: MarbleViewState {
        return MarbleViewState(
            input: [input1, input2],
            generator: { publisher, _ in
                let combined = self.operation(publisher[0], publisher[1])
                return SequenceExperiment(publisher: combined)
            }
        )
    }
}

extension SingleOperator {
    var state: MarbleViewState {
        return MarbleViewState(
            input: [input],
            generator: { publisher, scheduler in
                let combined = self.operation(publisher[0], scheduler)
                return SequenceExperiment(publisher: combined)
            }
        )
    }
}
