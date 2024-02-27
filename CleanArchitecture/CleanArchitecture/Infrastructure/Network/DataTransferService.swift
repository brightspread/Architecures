//
//  DataTransferService.swift
//  CleanArchitecture
//
//  Created by Leo on 2/27/24.
//

import Foundation

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

protocol DataTransferService {
    typealias TransferCompletionHandler<T> = (Result<T, DataTransferError>) -> Void
    
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E,
        completion: @escaping TransferCompletionHandler<T>
    ) -> NetworkCancellable? where E.Response == T
}

final class DefaultDataTransferService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

protocol DataTransferDispatchQueue {
    func asyncExecute(work: @escaping () -> Void)
}

extension DispatchQueue: DataTransferDispatchQueue {
    func asyncExecute(work: @escaping () -> Void) {
        async(group: nil, execute: work)
    }
}

extension DefaultDataTransferService: DataTransferService {
    
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E,
        on queue: DataTransferDispatchQueue,
        completion: @escaping TransferCompletionHandler<T>
    ) -> NetworkCancellable? where E.Response == T {
        networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(
                    data: data,
                    decoder: endpoint.responseDecoder
                )
                queue.asyncExecute { completion(result) }
            case .failure(let error):
                    queue.asyncExecute { completion(.failure(.networkFailure(error))) }
            }
        }
    }
    
    func request<T: Decodable, E: ResponseRequestable>(
        with endpoint: E, 
        completion: @escaping TransferCompletionHandler<T>
    ) -> NetworkCancellable? where E.Response == T  {
        request(with: endpoint, on: DispatchQueue.main, completion: completion)
    }
    
    // MARK: - Private
    private func decode<T: Decodable>(
        data: Data?,
        decoder: ResponseDecoder
    ) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            return .failure(.parsing(error))
        }
    }
    
}


// MARK: - Response Decoders
class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    init() { }
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

class RawDataResponseDecoder: ResponseDecoder {
    init() { }
    
    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }
    func decode<T: Decodable>(_ data: Data) throws -> T {
        if T.self is Data.Type, let data = data as? T {
            return data
        } else {
            let context = DecodingError.Context(
                codingPath: [CodingKeys.default],
                debugDescription: "Expected Data type"
            )
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }
    }
}
