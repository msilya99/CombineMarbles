//
//  MathematicalOperators.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import Foundation

extension Operators {
    var mathematical:OperatorCollection {
        OperatorCollection(
            name: "Applying Mathematical Operations on Elements",
            operators: [
                SingleOperator<String> (
                    name: "count()",
                    description: "count()",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204701-count",
                    operation: { pub, _ in pub.count().map { String($0) }.eraseToAnyPublisher() },
                    input: TimedEvent.defaultLatters
                ),
                SingleOperator<String> (
                    name: "max()",
                    description: "max()",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204720-max",
                    operation: { pub, _ in pub.max().map { String($0) }.eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "max(by:)",
                    description: "max { $0 < $1 }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204720-max",
                    operation: { pub, _ in pub.max { $0 < $1 }.map { String($0) }.eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "tryMax(by:)",
                    description: "tryMax { $0 < $1 }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204720-max",
                    operation: { pub, _ in pub
                            .tryMax { $0 < $1 }
                            .map { String($0) }
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "min()",
                    description: "min()",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204731-min",
                    operation: { pub, _ in pub.min().map { String($0) }.eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "min(by:)",
                    description: "min { $0 < $1 }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204732-min",
                    operation: { pub, _ in pub.min { $0 < $1 }.map { String($0) }.eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "tryMin(by: )",
                    description: "tryMin { $0 < $1 }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204774-trymin",
                    operation: { pub, _ in pub.tryMin { $0 < $1 }
                            .map { String($0) }
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                )
            ]
        )
    }
}
