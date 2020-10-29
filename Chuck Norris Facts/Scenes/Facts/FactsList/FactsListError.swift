//
//  FactsListError.swift
//  Chuck Norris Facts
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 10/28/20.
//  Copyright © 2020 Djorkaeff Alexandre Vilela Pereira. All rights reserved.
//

import Foundation

struct FactsListError {

    enum ErrorType {
        case syncCategories
        case searchFacts
    }

    let error: HTTPError?

    let type: ErrorType

    var message: String {
        switch error?.code {
        case .noConnection:
            return "Internet Connection appears to be offline."
        default:
            return "Looks like the Chuck Norris Service is unavailable."
        }
    }

    var retryEnabled: Bool {
        switch error?.code {
        case .noConnection:
            return false
        default:
            return true
        }
    }

    init(_ error: Error, type: ErrorType) {
        self.error = error as? HTTPError
        self.type = type
    }
}
