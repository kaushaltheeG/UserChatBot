//
//  UsersIndex.swift
//  UserChatBotPOC
//
//  Created by Kaushal Kumbagowdana on 6/13/23.
//

import SwiftUI

struct UsersIndex: View {
    @StateObject private var usersVm: UsersViewModel
    
    
    init(restService: RESTService) {
        _usersVm = StateObject(wrappedValue: UsersViewModel(restService: restService))
    }
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach(usersVm.users) { user in
                UserPannelView(name: user.name, id: user.id)
            }
        }
        .navigationTitle("Users")
        .onAppear {
            usersVm.getUsers()
        }
        
    }
}

struct UsersIndex_Previews: PreviewProvider {
    // invoking production RESTService
    static var previews: some View {
        UsersIndex(restService: RESTService())
    }
}
