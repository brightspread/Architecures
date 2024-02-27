//
//  GithubApp.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import SwiftUI

@main
struct GithubApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView(viewModel: .init(state: .init()))
        }
    }
}
