//
//  SearchReposUseCase.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import Foundation

protocol SearchReposUseCase {
    func execute(
        requestValue: SearchSearchUseCaseRequestValue, 
        completion: @escaping (Result<RepoResult, Error>) -> Void
    ) -> Cancellable?
}

final class DefaultSearchReposUseCase: SearchReposUseCase {
    private let reposRepository: RepoRepository
    
    init(reposRepository: RepoRepository) {
        self.reposRepository = reposRepository
    }
    
    func execute(
        requestValue: SearchSearchUseCaseRequestValue,
        completion: @escaping (Result<RepoResult, Error>) -> Void
    ) -> Cancellable? {
        return reposRepository.fetchRepoList(
            query: requestValue.query) {
                print(#function)
                
                if case .success = $0 {
                    
                }
                
                completion($0)
            }   
    }
}

struct SearchSearchUseCaseRequestValue {
    let query: String
}
