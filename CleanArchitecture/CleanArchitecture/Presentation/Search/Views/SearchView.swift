//
//  SearchView.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import SwiftUI
import Combine

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    @State private var query: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SearchBar(query: $query) {
                    viewModel.action(.queryUpdated($0))
                }
                SearchResultList(repos: viewModel.state.repos)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Github Search")
            .navigationBarTitleDisplayMode(.inline)
        }
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
