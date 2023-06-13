//
//  ContentView.swift
//  UserChatBotPOC
//
//  Created by Kaushal Kumbagowdana on 6/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: UsersIndex(restService: RESTService()), label: {
                    Text("Chat with User")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: 300)
                        .foregroundColor(.purple)
                        .background(Color.purple.opacity(0.5))
                        .cornerRadius(30)
                        .accessibilityIdentifier("navigationToUsersIndex")
                })
                
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Text("Show Alert!")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: 300)
                        .foregroundColor(.red)
                        .background(Color.red.opacity(0.4))
                        .cornerRadius(30)
                })
                .accessibilityIdentifier("showAlertButton")
                .alert(isPresented: $showAlert, content: {
                    return Alert(title: Text("Alert!!!"))
                })
            }
            .padding()
            .navigationTitle("Chat Bot Home")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
