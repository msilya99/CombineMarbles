//
//  SelectOperators.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import Foundation

extension Operators {
    var select: OperatorCollection {
        OperatorCollection(
            name: "Selecting Specific Elements",
            operators: [
                SingleOperator<String> (
                    name: "first",
                    description: "first()",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204710-first",
                    operation: { pub, _ in pub
                            .first()
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "first(where:)",
                    description: "first(where: { $0 > 3 })",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204711-first",
                    operation: { pub, _ in pub
                            .compactMap { Int($0)}
                            .first(where: { $0 > 3 })
                            .map { String($0) }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "tryFirst(where:)",
                    description: "tryFirst(where: { $0 > 3 })",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204770-tryfirst",
                    operation: { pub, _ in pub
                            .compactMap { Int($0)}
                            .tryFirst(where: { $0 > 3 })
                            .map { String($0) }
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "last",
                    description: "last()",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204715-last",
                    operation: { pub, _ in pub
                            .last()
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "last(where:)",
                    description: "last(where: { $0 > 3 })",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204716-last",
                    operation: { pub, _ in pub
                            .compactMap { Int($0)}
                            .last(where: { $0 > 1 })
                            .map { String($0) }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "tryLast(where:)",
                    description: "tryLast(where: { $0 > 3 })",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204771-trylast",
                    operation: { pub, _ in pub
                            .compactMap { Int($0)}
                            .tryFirst(where: { $0 > 1 })
                            .map { String($0) }
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "output(at:)",
                    description: "output(at: 2)",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204735-output",
                    operation: { pub, _ in pub
                            .compactMap { Int($0)}
                            .output(at: 2)
                            .map { String($0) }
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "output<R>(in:)",
                    description: "output(1..<3)",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204736-output",
                    operation: { pub, _ in pub
                            .compactMap { Int($0)}
                            .output(in: 1..<3)
                            .map { String($0) }
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                )
            ]
        )
    }
}
