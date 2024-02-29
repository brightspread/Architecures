//
//  SearchViewModel.swift
//  SimpleMVVM
//
//  Created by Leo on 2/28/24.
//

import SwiftUI
import Combine

final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published private(set) var repos: [Repo] = []
    
    private(set) var bag: Set<AnyCancellable> = []
    private var searchCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }     
    
    init() {
        bind()
    }
    
    func bind() {
        $query
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .filter { !$0.isEmpty }
            .sink { [weak self] query in
                guard let self else { return }
                guard let publisher = API.fetchRepoPublisher(query) else { return }
                searchCancellable = publisher
                    .receive(on: RunLoop.main)
                    .assign(to: \.repos, on: self)
            }
            .store(in: &bag)
    }
}
