//
//  DefaultRepoRepository.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import Foundation

final class DefaultRepoRepository {
    private let dataTransferService: DataTransferService
    private let backgroundQueue: DataTransferDispatchQueue
    
    init(dataTransferService: DataTransferService, 
         backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)) {
        self.dataTransferService = dataTransferService
        self.backgroundQueue = backgroundQueue
    }
}

extension DefaultRepoRepository: RepoRepository {
    func fetchRepoList(
        query: String, 
        completion: @escaping (Result<RepoResult, Error>) -> Void
    ) -> Cancellable? {
        let endpoint = APIEndpoints.getRepos(with: .init(q: query))
        let task = RepositoryTask()
        task.networkTask = dataTransferService.request(
            with: endpoint) {
                let result = $0.mapError { $0 as Error }
                completion(result)
            }
        return task
    }
}
