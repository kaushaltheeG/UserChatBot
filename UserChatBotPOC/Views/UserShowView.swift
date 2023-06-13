//
//  UserShowView.swift
//  UserChatBotPOC
//
//  Created by Kaushal Kumbagowdana on 6/13/23.
//

import SwiftUI

struct UserShowView: View {
    @StateObject private var usersVm: UsersViewModel
    @State private var userId: Int
    
    init(restService: RESTService, userId: Int) {
        _usersVm = StateObject(wrappedValue: UsersViewModel(restService: restService))
        self.userId = userId
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                // user's header
                VStack(spacing:5) {
                    // for Profile Icon and username
                    
                    // Profile Icon
                    Text(String(usersVm.showUser?.name ?? "FakeName").prefix(1))
                      .frame(width: 20, height: 20)
                      .foregroundColor(.white)
                      .padding(20)
                      .background(Color.green)
                      .clipShape(Circle())
                    
                    // Username
                    Text("@" + String((usersVm.showUser?.username) ?? "fake_username"))
                }
                .frame(maxWidth: 100)
                VStack(spacing: 5) {
                    // for name and email
                    Text(String((usersVm.showUser?.name) ?? "Fake Name"))
                    Text(String((usersVm.showUser?.email) ?? "Fake Email"))
                }
                .frame(maxWidth: 250)
            }
            .frame(maxWidth: 500, maxHeight: 100)
            Spacer()
            
        }
        .background(.gray)
        .onAppear {
            usersVm.getUser(id: userId)
        }
    }
}

struct UserShowView_Previews: PreviewProvider {
    static var previews: some View {
        UserShowView(restService: RESTService(), userId: 0)
    }
}
