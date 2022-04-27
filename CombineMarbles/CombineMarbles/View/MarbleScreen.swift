//
//  MarbleScreen.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import SwiftUI
import Combine

class MarbleViewState: ObservableObject {

    private var generator: ([SequancePublisher], SequnceScheduler) -> SequanceExperimentRunner
    private var cancellable = Set<AnyCancellable>()

    @Published var input: [[TimedEvent]] {
        didSet { update() }
    }

    @Published var output: [TimedEvent] = []

    init(input: [[TimedEvent]], generator: @escaping ([SequancePublisher], SequnceScheduler) -> SequanceExperimentRunner) {
        self.input = input
        self.generator = generator
    }

    func update() {
        let scheduler = SequnceScheduler()
        generator(self.input.map { SequancePublisher(events: $0, scheduler: scheduler) }, scheduler)
            .run(scheduler: scheduler)
            .receive(on: RunLoop.main)
            .assign(to: \.output, on: self)
            .store(in: &cancellable)
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

struct MarblesScreen: View {
    @ObservedObject var state: MarbleViewState

    let operation: Operator

    init(operation: Operator) {
        self.operation = operation
        state = operation.state
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 24) {
                ForEach(0..<state.input.count) {
                    MarbleLane(pos: self.$state.input[$0], isDraggable: true)
                        .frame(height: 44)
                }
            }

            Text(operation.description)
                .padding(16)
                .background(RoundedRectangle(cornerRadius: 16).stroke(.foreground))
                .font(.system(size: 20))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 16)

            MarbleLane(pos: $state.output, isDraggable: false)
                .frame(height: 44)

            DocumentationLink(
                name: self.operation.name,
                url: self.operation.documentationURL
            )
            .padding(.top, 16)
            Spacer()
        }
        .padding(.vertical, 36)
        .padding(.horizontal, 12)
        .navigationBarTitle(operation.name)
        .onAppear { self.state.update() }
    }
}
