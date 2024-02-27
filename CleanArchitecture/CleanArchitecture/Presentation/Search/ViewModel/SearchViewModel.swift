//
//  SearchViewModel.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import SwiftUI
import Combine

extension SearchViewState {
    var query: String { return _query }
}

enum SearchViewAction {
    case queryUpdated(String)
}

final class SearchViewModel: ViewModel {
    
    @Published var state: SearchViewState
    
    init(state: SearchViewState) {
        self.state = state
    }
    
    func action(_ action: SearchViewAction) {
        switch action {
            case .queryUpdated(let query):
                state.updateQuery(query)
        }
    }
}

fileprivate extension SearchViewState {
    mutating func updateQuery(_ query: String) {
        self._query = query
    }
}

struct SearchViewState {
    private var _query: String = ""
}
