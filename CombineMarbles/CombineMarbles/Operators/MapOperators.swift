//
//  MapOperators.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import Foundation

extension TimedEvent {
    static var defaultLatters: [TimedEvent] {
        [.next(10, "A"), .next(30, "B"), .next(50, "C"), .next(70, "D"), .finished(90)]
    }

    static var defaultNumbers: [TimedEvent] {
        [.next(10, "1"), .next(30, "2"), .next(50, "3"), .next(70, "4"), .finished(90)]
    }
}

extension Operators {
    var map: OperatorCollection {
        OperatorCollection(
            name: "Mapping Element",
            operators: [
                SingleOperator<String> (
                    name: "map()",
                    description: "map { \"\\($0)\\($0)\" }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204718-map",
                    operation: { pub, _ in pub.map { "\($0)\($0)" }.eraseToAnyPublisher() },
                    input: TimedEvent.defaultLatters
                ),
                SingleOperator<String> (
                    name: "tryMap()",
                    description: "tryMap { \"\\($0)\\($0)\" }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204772-trymap",
                    operation: { pub, _ in pub
                            .tryMap { "\($0)\($0)" }
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultLatters
                ),
                SingleOperator<String> (
                    name: "scan()",
                    description: "scan(0) { $0 + $1 }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3229094-scan",
                    operation: { pub, _ in pub
                            .compactMap { Int($0) }
                            .scan(0) { $0 + $1 }
                            .map { String($0) }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "tryScan()",
                    description: "tryScan(0) { $0 + $1 }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3229095-tryscan",
                    operation: { pub, _ in pub
                            .compactMap { Int($0) }
                            .scan(0) { $0 + $1 }
                            .map { String($0) }
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                )
            ]
        )
    }
}
