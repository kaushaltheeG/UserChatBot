//
//  UsersViewModel.swift
//  UserChatBotPOC
//
//  Created by Kaushal Kumbagowdana on 6/12/23.
//

import Foundation
import Combine

class UsersViewModel: ObservableObject {
    
    @Published var users: [User]
    @Published var showUser: User?
    private let restService: RESTService = RESTService()
    private var cancellables = Set<AnyCancellable>()
    private var url: String = "https://jsonplaceholder.typicode.com/users"
    
    init(users: [User], user: User? = nil) {
        self.users = users
        self.showUser = user
        
        // invokes to fill users array
        getUsers()
    }
    
    func getUsers() {
        restService.getRequest(urlString: url, type: User.self)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print("Error is \(err.localizedDescription)")
                case .finished:
                    print("Finished")
                }
            }
            receiveValue: { [weak self] usersData in
                self?.users = usersData
                self?.showUser = nil
            }
            .store(in: &cancellables)
    }
    
    func getUser(id: Int) {
        restService.getRequest(urlString: url, type: User.self)
            .map { userData in
                return userData.filter { $0.id == id }
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("getUser Error: \(error)")
                case .finished:
                    print("Finished")
                }
            }, receiveValue: {[weak self] userData in
                self?.showUser = userData.first
            })
            .store(in: &cancellables)
    }
    
    
    
}
