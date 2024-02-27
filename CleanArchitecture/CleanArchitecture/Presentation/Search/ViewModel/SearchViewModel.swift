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
    case searchRepo(String)
}

final class SearchViewModel: ViewModel {
    private let searchReposUseCase: SearchReposUseCase
    
    @Published var state: SearchViewState
    
    private var reposLoadTask: Cancellable? { willSet { reposLoadTask?.cancel() } }

    
    init(searchReposUseCase: SearchReposUseCase,
         state: SearchViewState) {
        self.searchReposUseCase = searchReposUseCase
        self.state = state
    }
    
    
    func action(_ action: SearchViewAction) {
        switch action {
            case .queryUpdated(let query):
                state.updateQuery(query)
                self.action(.searchRepo(state.query))
            case .searchRepo(let query):
                reposLoadTask = searchReposUseCase.execute(
                    requestValue: .init(query: query)
                ) { [weak self] result in
                    print(result)
                }
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
