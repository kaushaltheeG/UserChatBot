//
//  MockRESTService.swift
//  UserChatBotPOC_UnitTests
//
//  Created by Kaushal Kumbagowdana on 6/13/23.
//

import Foundation
import Combine
@testable import UserChatBotPOC

final class MockRESTService: RESTServiceProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    
    func getRequest<T>(urlString: String, type: T.Type) -> Future<[T], Error> {
        return Future<[T], Error> { [weak self] promise in
            guard let _ = self, let _ = URL(string: urlString) else {
                return promise(.failure(RESTServiceError.invalidURL))
            }
            // testing subscriber's cases within each unit test
            
            // return empty array for success
            return promise(.success([]))
        }
    }
}
