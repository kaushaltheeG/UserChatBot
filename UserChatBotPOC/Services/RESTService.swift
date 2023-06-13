//
//  RESTService.swift
//  UserChatBotPOC
//
//  Created by Kaushal Kumbagowdana on 6/12/23.
//

import Foundation
import Combine

final class RESTService: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    func getRequest<T: Decodable>(urlString: String, id: Int?=nil, type: T.Type) -> Future<[T], Error> {
        return Future<[T], Error> { [weak self] promise in
            guard let self = self, let url = URL(string: urlString.appending(id == nil ? "" : "/\(id ?? 0)")) else {
                return promise(.failure(RESTServiceError.invalidURL))
            }
            
            print("URL is \(url)")
            // Start of Publisher
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap{ (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200, httpResponse.statusCode < 300 else {
                        throw RESTServiceError.responseError
                    }
                    return data
                }
                .decode(type: [T].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main) // scheduler
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as RESTServiceError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(RESTServiceError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &cancellables)
                
        }
    }
}


enum RESTServiceError: Error {
    case invalidURL
    case responseError
    case unknown
}

extension RESTServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}

                                                 
                                                 
                                                 
