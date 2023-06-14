//
//  RESTServiceProtocol.swift
//  UserChatBotPOC
//
//  Created by Kaushal Kumbagowdana on 6/13/23.
//

import Foundation
import Combine

protocol RESTServiceProtocol {
    func getRequest<T: Decodable>(urlString: String, type: T.Type) -> Future<[T], Error>
}
