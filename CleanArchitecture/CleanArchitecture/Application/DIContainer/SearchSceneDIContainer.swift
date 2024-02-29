//
//  SearchSceneDIContainer.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import SwiftUI

final class SearchSceneDIContainer: SearchFlowCoordinatorDependencies {
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeSearchRepoUseCase() -> SearchReposUseCase {
        DefaultSearchReposUseCase(
            reposRepository: makeRepoRepository()
        )
    }
    
    private func makeRepoRepository() -> RepoRepository {
        DefaultRepoRepository(
            dataTransferService: dependencies.apiDataTransferService
        )
    }
    
    func makeSearchView() -> SearchView {
        return SearchView(
            viewModel: .init(
                searchReposUseCase: self.makeSearchRepoUseCase(), 
                state: .init()
            )
        )
    }
    
//    func makeSearchFlowCoordinator() -> SearchFlowCoordinator {
//        SearchFlowCoordinator(dependencies: self)
//    }
}
