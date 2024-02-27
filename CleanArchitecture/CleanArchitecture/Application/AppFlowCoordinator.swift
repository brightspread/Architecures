//
//  AppFlowCoordinator.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import SwiftUI

final class AppFlowCoordinator {
    private let appDIContainer: AppDIContainer
    
    init(appDIContainer: AppDIContainer) {
        self.appDIContainer = appDIContainer
    }
    
    @ViewBuilder
    func buildStartView() -> some View {
        let repoSceneDIContainer = appDIContainer.makeSearchSceneDIConatiner()
        repoSceneDIContainer.makeSearchView()
        //let flow = repoSceneDIContainer.makeSearchFlowCoordinator()
    }
}
