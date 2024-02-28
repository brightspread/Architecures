//
//  SearchBar.swift
//  SimpleMVVM
//
//  Created by Leo on 2/28/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var query: String
    let queryUpdateAction: (String) -> ()?
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 20, height: 20)
                    
                TextField("Search Repositories", text: $query)
                    .onSubmit {
                        queryUpdateAction(query)
                    }
            }
            
            Button {
                queryUpdateAction(query)
            } label: {
                Text("Search")
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

