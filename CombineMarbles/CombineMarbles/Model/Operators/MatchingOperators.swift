//
//  MatchingOperators.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import Foundation

extension Operators {
    var matching: OperatorCollection {
        OperatorCollection(
            name: "Applying Matching Criteria to Elements",
            operators: [
                SingleOperator<String> (
                    name: "contains()",
                    description: "contains(2)",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204699-contains",
                    operation: { pub, _ in
                        pub.compactMap { Int($0) }
                            .contains(2)
                            .map { "\($0)" }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "contains(where:)",
                    description: "contains(where: { $0 == 2})",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204700-contains",
                    operation: { pub, _ in pub
                            .compactMap { Int($0) }
                            .contains(where: { $0 == 2})
                            .map { "\($0)" }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "tryContains(where:)",
                    description: "tryContains(where: { $0 == 2})",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204767-trycontains",
                    operation: { pub, _ in pub
                            .compactMap { Int($0) }
                            .contains(where: { $0 == 2})
                            .map { "\($0)" }
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "allSatisfy(_:)",
                    description: "allSatisfy({ $0 < 3})",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204682-allsatisfy",
                    operation: { pub, _ in pub
                            .compactMap { Int($0) }
                            .allSatisfy({ $0 < 3})
                            .map { "\($0)" }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "tryAllSatisfy(_:)",
                    description: "tryAllSatisfy({ $0 < 3})",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204762-tryallsatisfy",
                    operation: { pub, _ in pub
                            .compactMap { Int($0) }
                            .tryAllSatisfy({ $0 < 3})
                            .map { "\($0)" }
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
            ]
        )
    }
}
