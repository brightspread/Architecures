//
//  API.swift
//  SimpleMVVM
//
//  Created by Leo on 2/28/24.
//

import Foundation
import Combine

struct API {
    static func fetchRepo(_ query: String) async throws -> [Repo] {
        guard let url = buildRepoURL(query) else { return [] }
        let (data, response) = try await URLSession.shared.data(from: url)
        print(response)
        let results = try JSONDecoder().decode(RepoResult.self, from: data)
        return results.items
    }
    
    static func fetchRepoPublisher(_ query: String) -> AnyPublisher<[Repo], Never>? {
        guard let url = buildRepoURL(query) else { return nil }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map {  $0.data }
            .decode(type: RepoResult.self, decoder: JSONDecoder())
            .map { $0.items }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    static func buildRepoURL(_ query: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/search/repositories"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]
        
        return urlComponents.url
    }
}
