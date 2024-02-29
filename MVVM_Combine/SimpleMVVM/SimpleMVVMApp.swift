//
//  SimpleMVVMApp.swift
//  SimpleMVVM
//
//  Created by Leo on 2/28/24.
//

import SwiftUI

@main
struct SimpleMVVMApp: App {
    @StateObject private var searchViewModel = SearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            SearchView(viewModel: searchViewModel)
        }
    }
}
