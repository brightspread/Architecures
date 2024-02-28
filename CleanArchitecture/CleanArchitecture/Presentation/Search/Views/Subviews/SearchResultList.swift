//
//  SearchResultList.swift
//  CleanArchitecture
//
//  Created by Leo on 2/28/24.
//

import SwiftUI

struct SearchResultList: View {
    let repos: [Repo]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(repos) { repo in
                    HStack {
                        Text(repo.fullName)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
