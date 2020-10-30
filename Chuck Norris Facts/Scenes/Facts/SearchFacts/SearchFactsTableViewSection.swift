//
//  SearchFactsTableViewSection.swift
//  Chuck Norris Facts
//
//  Created by Djorkaeff Alexandre Vilela Pereira on 10/26/20.
//  Copyright © 2020 Djorkaeff Alexandre Vilela Pereira. All rights reserved.
//

import RxDataSources

enum SearchFactsTableViewItem {
    case SuggestionsTableViewItem(suggestions: [SuggestionsSectionModel])
    case PastSearchTableViewItem(model: PastSearchViewModel)
}

extension SearchFactsTableViewItem {
    var quantity: Int {
        switch self {
        case .SuggestionsTableViewItem(let suggestions):
            return suggestions.first?.items.count ?? 0
        default:
            return 0
        }
    }
}

enum SearchFactsTableViewSection {
    case SuggestionsSection(items: [SearchFactsTableViewItem])
    case PastSearchesSection(items: [SearchFactsTableViewItem])
}

extension SearchFactsTableViewSection: SectionModelType {
    typealias Item = SearchFactsTableViewItem

    var header: String {
        switch self {
        case .SuggestionsSection:
            return L10n.SearchFacts.Sections.suggestions
        case .PastSearchesSection:
            return L10n.SearchFacts.Sections.pastSearches
        }
    }

    var items: [SearchFactsTableViewItem] {
        switch self {
        case .SuggestionsSection(let items):
            return items
        case .PastSearchesSection(let items):
            return items
        }
    }

    init(original: Self, items: [Self.Item]) {
        self = original
    }
}
