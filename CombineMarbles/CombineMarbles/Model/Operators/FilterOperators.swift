//
//  FilterOperators.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 27.04.22.
//

import Foundation
import Combine

extension Operators {
    var filter: OperatorCollection {
        OperatorCollection(
            name: "Filtering Elements",
            operators: [
                SingleOperator<String> (
                    name: "filter()",
                    description: "filter { $0 % 2 == 0 }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204709-filter",
                    operation: { pub, _ in pub
                            .compactMap { Int($0) }
                            .filter { $0 % 2 == 0  }
                            .map { String($0) }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "tryFilter()",
                    description: "tryFilter { $0 % 2 == 0 }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204769-tryfilter",
                    operation: { pub, _ in pub
                            .compactMap { Int($0) }
                            .filter { $0 % 2 == 0  }
                            .map { String($0) }
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "compactMap()",
                    description: "compactMap { $0 % 2 == 0 ? nil : \"e\"  }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204698-compactmap",
                    operation: { pub, _ in pub
                            .compactMap { Int($0) }
                        .compactMap { $0 % 2 == 0 ? nil : "e"  }.eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "tryCompactMap()",
                    description: "tryCompactMap { $0 % 2 == 0 ? nil : \"e\"  }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204766-trycompactmap",
                    operation: { pub, _ in pub
                            .compactMap { Int($0) }
                            .compactMap { $0 % 2 == 0 ? nil : "e"  }
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: TimedEvent.defaultNumbers
                ),
                SingleOperator<String> (
                    name: "removeDuplicates()",
                    description: "removeDuplicates()",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204745-removeduplicates",
                    operation: { pub, _ in pub.removeDuplicates().eraseToAnyPublisher() },
                    input: [
                        .next(10, "1"),
                        .next(30, "2"),
                        .next(50, "2"),
                        .next(70, "4"),
                        .finished(90)
                    ]
                ),
                SingleOperator<String> (
                    name: "removeDuplicates(by:)",
                    description: "removeDuplicates { $0 == $1 }",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204746-removeduplicates",
                    operation: { pub, _ in pub.removeDuplicates { $0 == $1 }.eraseToAnyPublisher() },
                    input: [
                        .next(10, "1"),
                        .next(30, "2"),
                        .next(50, "2"),
                        .next(70, "4"),
                        .finished(90)
                    ]
                ),
                SingleOperator<String> (
                    name: "tryRemoveDuplicates(by:)",
                    description: "tryRemoveDuplicates(by: { $0 == $1 })",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204777-tryremoveduplicates",
                    operation: { pub, _ in pub
                            .tryRemoveDuplicates(by: { $0 == $1 })
                            .mapError { _ in FailureString(content: "") }
                            .eraseToAnyPublisher()
                    },
                    input: [
                        .next(10, "1"),
                        .next(30, "2"),
                        .next(50, "2"),
                        .next(70, "4"),
                        .finished(90)
                    ]
                ),
                SingleOperator<String> (
                    name: "replaceError(with:)",
                    description: "replaceError(with: \"A\")",
                    documentationURL: "https://developer.apple.com/documentation/combine/publisher/3204748-replaceerror",
                    operation: { pub, _ in pub
                            .replaceError(with: "A")
                            .mapError { _ in FailureString(content: "") }
                        .eraseToAnyPublisher() },
                    input: [
                        .next(10, "1"),
                        .next(30, "2"),
                        .next(50, "2"),
                        .error(70, "")
                    ]
                )
            ]
        )
    }
}
