//
//  FactsListViewModel.swift
//  Chuck Norris Facts
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 10/10/20.
//  Copyright © 2020 Djorkaeff Alexandre Vilela Pereira. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

typealias FactsSectionModel = AnimatableSectionModel<String, FactViewModel>

final class FactsListViewModel {

    // MARK: - Inputs

    let viewDidAppear: AnyObserver<Void>

    let startShareFact: AnyObserver<FactViewModel>

    // MARK: - Outputs

    let facts: Observable<[FactsSectionModel]>

    let showShareFact: Observable<FactViewModel>

    init(factsService: FactsServiceType = FactsService()) {

        let viewDidAppearSubject = PublishSubject<Void>()
        self.viewDidAppear = viewDidAppearSubject.asObserver()

        self.facts = viewDidAppearSubject.flatMapLatest { _ in factsService.searchFacts(query: "") }
            .map { Array($0.shuffled().prefix(10)) }
            .map { $0.map { FactViewModel(fact: $0) } }
            .map { [FactsSectionModel(model: "", items: $0)] }

        let startShareFactSubject = PublishSubject<FactViewModel>()
        self.startShareFact = startShareFactSubject.asObserver()
        self.showShareFact = startShareFactSubject.asObservable()
    }
}
