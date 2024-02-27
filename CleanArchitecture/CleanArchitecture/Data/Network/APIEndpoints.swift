//
//  APIEndpoints.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import Foundation

struct APIEndpoints {
//https://api.github.com/search/repositories?q={
    static func getRepos(with repoRequestDTO: RepoRequestDTO) -> Endpoint<RepoResult> {
        return Endpoint(
            path: "search/repositories", 
            method: .get,
            queryParametersEncodable: repoRequestDTO
        )
    }
}

struct RepoRequestDTO: Encodable {
    let q: String
}
