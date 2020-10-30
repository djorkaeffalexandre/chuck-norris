//
//  FactsListScene.swift
//  Chuck Norris FactsUITests
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 10/12/20.
//  Copyright © 2020 Djorkaeff Alexandre Vilela Pereira. All rights reserved.
//

import Foundation
import XCTest

struct FactsListScene {

    let factsTableView: XCUIElement
    let emptyListView: XCUIElement
    let emptyListLabelView: XCUIElement
    let searchButton: XCUIElement
    let errorView: XCUIElement
    let retryButton: XCUIElement

    init() {
        let app = XCUIApplication()

        factsTableView = app.tables["factsTableView"]
        emptyListView = app.otherElements["emptyListView"]
        emptyListLabelView = app.staticTexts["emptyListLabelView"]
        searchButton = app.navigationBars.buttons["searchButton"]
        errorView = app.otherElements["errorView"]
        retryButton = app.buttons["retryButton"]
    }

}
