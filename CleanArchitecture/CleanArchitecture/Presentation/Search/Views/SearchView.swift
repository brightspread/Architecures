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
    SearchView(viewModel: .init(state: .init()))
}
