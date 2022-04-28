//
//  Operators.swift
//  CombineMarbles
//
//  Created by Ilya Maslau on 28.04.22.
//

import Foundation

enum Operators: CaseIterable {
    case map
    case filter
    case reduce
    case mathematical
    case matching
    case sequence
    case select
    case combine
    case timing

    func getOperatorCollection() -> OperatorCollection {
        switch self {
        case .map:
            return map
        case .filter:
            return filter
        case .reduce:
            return reduce
        case .mathematical:
            return mathematical
        case .matching:
            return matching
        case .sequence:
            return sequence
        case .select:
            return select
        case .combine:
            return combine
        case .timing:
            return timing
        }
    }
}
