//
//  SearchFlowCoordinator.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import Foundation

protocol SearchFlowCoordinatorDependencies {
    func makeSearchView() -> SearchView
}

final class SearchFlowCoordinator {
    private let dependencies: SearchFlowCoordinatorDependencies
    
    init(dependencies: SearchFlowCoordinatorDependencies) {
        self.dependencies = dependencies
    }
}
