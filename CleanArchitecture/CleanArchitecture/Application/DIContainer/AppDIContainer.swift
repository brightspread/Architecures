//
//  AppDIContainer.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import Foundation

final class AppDIContainer {
    lazy var appConfiguration = AppConfiguration()
    
    lazy var apiDataTranserferService: DataTransferService = {
        let config = ApiDataNetworkConfig(
            baseURL: URL(string: appConfiguration.apiBaseURL)!
        )
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(networkService: apiDataNetwork)
    }()
    
    func makeSearchSceneDIConatiner() -> SearchSceneDIContainer {
        let dependencies = SearchSceneDIContainer.Dependencies(
            apiDataTransferService: apiDataTranserferService
        )
        return SearchSceneDIContainer(dependencies: dependencies)
    }
}
