//
//  TimingOperators.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import Foundation

extension Operators {
    var timing: OperatorCollection {
        OperatorCollection(
            name: "Controlling Timing",
            operators: [
                SingleOperator<String> (
                    name: "measureInterval(using:)",
                    description: "measureInterval(using: scheduler)",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204722-measureinterval",
                    operation: { pub, scheduler in
                        pub
                            .measureInterval(using: scheduler)
                            .map { "\(Double($0.magnitude) / 1_000_000_000.0)" }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "debounce(for:)",
                    description: "debounce(for: .milliseconds(200), scheduler: scheduler)", documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204702-debounce",
                    operation: { pub, scheduler in pub
                            .debounce(for: .milliseconds(30), scheduler: scheduler)
                        .eraseToAnyPublisher() },
                    input: [.next(10, "A"), .next(20, "B"), .next(55, "C"), .finished(90)]
                ),
                SingleOperator<String> (
                    name: "delay(for:scheduler:)",
                    description: "delay(for: .milliseconds(10), scheduler: scheduler)", documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204704-delay",
                    operation: { pub, scheduler in pub
                            .delay(for: .milliseconds(10), scheduler: scheduler)
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "throttle(for:scheduler:latest:)",
                    description: "throttle(for: .milliseconds(30), scheduler: scheduler, latest: false)",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204760-throttle",
                    operation: { pub, scheduler in pub
                            .throttle(for: .milliseconds(30), scheduler: scheduler, latest: true)
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "timeout(_:scheduler:)",
                    description: "timeout(.milliseconds(30), scheduler: scheduler)", documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204761-timeout",
                    operation: { pub, scheduler in pub
                            .timeout(.milliseconds(30), scheduler: scheduler)
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                )
            ]
        )
    }
}
