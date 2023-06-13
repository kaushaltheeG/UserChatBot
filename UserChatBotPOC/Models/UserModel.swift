//
//  UserModel.swift
//  UserChatBotPOC
//
//  Created by Kaushal Kumbagowdana on 6/12/23.
//

import Foundation


struct User: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
    var username: String
    var email: String
}
