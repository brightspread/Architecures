//
//  SearchViewModel.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import SwiftUI
import Combine

struct SearchViewState {
    fileprivate(set) var query: String = ""
    fileprivate(set) var repos: [Repo] = []
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
                state.query = query
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
                    state.repos = result.items
                case .failure(let error):
                    print(error)
            }
        }
    }
}
