//
//  FactsService.swift
//  Chuck Norris Facts
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 10/20/20.
//  Copyright © 2020 Djorkaeff Alexandre Vilela Pereira. All rights reserved.
//

import RxSwift
import Moya

protocol FactsServiceType {
    func searchFacts(searchTerm: String) -> Observable<[Fact]>
    func syncCategories() -> Observable<Void>
    func retrieveCategories() -> Observable<[FactCategory]>
}

struct FactsService: FactsServiceType {

    private let provider = MoyaProvider<FactsAPI>()
    private let storage = FactsStorage()

    func searchFacts(searchTerm: String) -> Observable<[Fact]> {
        provider.rx
            .request(.searchFacts(searchTerm: searchTerm))
            .asObservable()
            .map(SearchFactsResponse.self, using: JSON.decoder)
            .map { $0.facts }
    }

    func syncCategories() -> Observable<Void> {
        _ = provider.rx
            .request(.getCategories)
            .subscribe { event in
                switch event {
                case .success(let response):
                    if let categories = try? response.map([FactCategory].self, using: JSON.decoder) {
                        self.storage.storeCategories(categories)
                    }
                case .error(let error):
                    print(error)
                }
            }
        return .just(())
    }

    func retrieveCategories() -> Observable<[FactCategory]> {
        storage.retrieveCategories()
    }

}
