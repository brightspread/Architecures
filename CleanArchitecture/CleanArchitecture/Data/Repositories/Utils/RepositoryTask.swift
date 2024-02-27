//
//  RepositoryTask.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import Foundation

class RepositoryTask: Cancellable {
    var networkTask: NetworkCancellable?
    var isCancelled: Bool = false
    
    func cancel() {
        networkTask?.cancel()
        isCancelled = true
    }
}
