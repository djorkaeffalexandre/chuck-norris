//
//  SearchFactsViewControllerTests.swift
//  Chuck Norris FactsTests
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 10/21/20.
//  Copyright © 2020 Djorkaeff Alexandre Vilela Pereira. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
import RxTest

@testable import Chuck_Norris_Facts

class SearchFactsViewControllerTests: XCTestCase {

    var searchFactsViewController: SearchFactsViewController!
    var searchFactsViewModel: SearchFactsViewModel!
    var factsServiceMock: FactsServiceMock!
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUp() {
        disposeBag = DisposeBag()
        testScheduler = TestScheduler(initialClock: 0)
        factsServiceMock = FactsServiceMock()
        searchFactsViewModel = SearchFactsViewModel(factsService: factsServiceMock)
        searchFactsViewController = SearchFactsViewController()
        searchFactsViewController.viewModel = searchFactsViewModel

        searchFactsViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        disposeBag = nil
        testScheduler = nil
        searchFactsViewModel = nil
        factsServiceMock = nil
    }

    func test_factCategoriesViewShouldShow8Categories() throws {
        let stubFactCategories = try stub("get-categories", type: [FactCategory].self) ?? []
        factsServiceMock.retrieveCategoriesReturnValue = .just(stubFactCategories)

        searchFactsViewModel.viewWillAppear.onNext(())

        let tableView = searchFactsViewController.tableView
        let searchFactsDataSource = tableView.dataSource
        let indexPath = IndexPath(row: 0, section: 0)
        let suggestionsCell = searchFactsDataSource?.tableView(tableView, cellForRowAt: indexPath) as? SuggestionsCell

        XCTAssertEqual(suggestionsCell?.collectionView.numberOfItems(inSection: 0), 8)
    }
}
