//
//  MarbleViewState.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 28.04.22.
//

import Foundation
import Combine

class MarbleViewState: ObservableObject {

    // MARK: - variables

    @Published var input: [[TimedEvent]] {
        didSet { update() }
    }

    @Published var output: [TimedEvent] = []

    private let initionalState: (input: [[TimedEvent]], generator: ([SequancePublisher], SequenceScheduler) -> SequanceExperimentRunner)
    private var generator: ([SequancePublisher], SequenceScheduler) -> SequanceExperimentRunner
    private var cancellable = Set<AnyCancellable>()

    // MARK: - initialization

    init(input: [[TimedEvent]], generator: @escaping ([SequancePublisher], SequenceScheduler) -> SequanceExperimentRunner) {
        self.input = input
        self.generator = generator
        self.initionalState = (input, generator)
    }

    // MARK: - actions

    func update() {
        let scheduler = SequenceScheduler()
        generator(self.input.map { SequancePublisher(events: $0, scheduler: scheduler) }, scheduler)
            .run(scheduler: scheduler)
            .receive(on: RunLoop.main)
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
                return SequanceExperiment(publisher: combined)
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
                return SequanceExperiment(publisher: combined)
            }
        )
    }
}
