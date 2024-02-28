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
    var repos: [Repo] { return _repos }
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
                    guard let self else { return }
                    self.reduceFetchedRepos(with: result)
                }
        }
    }
    
    private func reduceFetchedRepos(with result: Result<RepoResult, Error>) {
        Task { @MainActor in
            switch result {
                case .success(let result):
                    self.state.changeRepos(result.items)
                case .failure(let error):
                    print(error)
            }
        }
    }
}

fileprivate extension SearchViewState {
    mutating func updateQuery(_ query: String) {
        self._query = query
    }
    
    mutating func changeRepos(_ repos: [Repo]) {
        self._repos = repos
    }
}

struct SearchViewState {
    private var _query: String = ""
    private var _repos: [Repo] = []
}
