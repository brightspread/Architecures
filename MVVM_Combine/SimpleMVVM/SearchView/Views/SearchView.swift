//
//  SearchView.swift
//  SimpleMVVM
//
//  Created by Leo on 2/28/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SearchBar(query: $viewModel.query) { _ in
                }
                SearchResultList(repos: viewModel.repos)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Github Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
