//
//  FactsListViewModel.swift
//  Chuck Norris Facts
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 10/10/20.
//  Copyright © 2020 Djorkaeff Alexandre Vilela Pereira. All rights reserved.
//

import Foundation
import RxSwift

final class FactsListViewModel {

    // MARK: - Outputs

    let facts: Observable<[Fact]>

    init(factsService: FactsService = FactsService()) {
        self.facts = factsService.searchFacts(query: "")
    }
}
