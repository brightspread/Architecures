//
//  GithubApp.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import SwiftUI

@main
struct GithubApp: App {
    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    
    init() {
        appFlowCoordinator = AppFlowCoordinator(appDIContainer: appDIContainer)
    }
    
    var body: some Scene {
        return WindowGroup {
            appFlowCoordinator?.buildStartView()
            //SearchView(viewModel: .init(state: .init()))
        }
    }
}
