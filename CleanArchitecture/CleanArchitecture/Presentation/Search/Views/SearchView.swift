//
//  SearchView.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import SwiftUI
import Combine

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    @State private var query: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchBar
                // Searched Lists
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Github Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var searchBar: some View {
        return HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 20, height: 20)
                    
                TextField("Search Repositories", text: $query)
                    .onSubmit {
                        viewModel.action(.queryUpdated(query))
                    }
            }
            
            Button {
                viewModel.action(.queryUpdated(query))
            } label: {
                Text("Search")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    let apiDataNetworkConfig = ApiDataNetworkConfig(baseURL: URL(string: "https://api.github.com/")!)
    let networkService = DefaultNetworkService(config: apiDataNetworkConfig)
    let dataTransferService = DefaultDataTransferService(networkService: networkService)
    let reposRepository = DefaultRepoRepository(dataTransferService: dataTransferService)
    let searchReposUseCase = DefaultSearchReposUseCase(reposRepository: reposRepository)
    
    return SearchView(
        viewModel: .init(
            searchReposUseCase: searchReposUseCase,
            state: .init()
        )
    )
}
