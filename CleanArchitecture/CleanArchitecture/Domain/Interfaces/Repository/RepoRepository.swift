//
//  RepoRepository.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import Foundation

protocol RepoRepository {
    func fetchRepoList(
        query: String,
        completion: @escaping (Result<RepoResult, Error>) -> Void
    ) -> Cancellable?
}
