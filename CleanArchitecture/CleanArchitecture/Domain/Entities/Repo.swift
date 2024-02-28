//
//  Repo.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import Foundation

struct RepoResult: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repo]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct Repo: Codable, Identifiable {
    let id: Int
    let fullName: String
    let htmlURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case htmlURL = "html_url"
    }
}
