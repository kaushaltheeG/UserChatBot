//
//  UserPannel.swift
//  UserChatBotPOC
//
//  Created by Kaushal Kumbagowdana on 6/13/23.
//

import SwiftUI

struct UserPannelView: View {
    @State var name: String
    @State var id: Int
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    var body: some View {
        NavigationLink(destination: UserShowView(restService: RESTService(), userId: id), label: {
                HStack(spacing: 0){
                    Text(String(name.prefix(1)))
                        .padding()
                        .background(Color.purple.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    Text("\(name)")
                        .foregroundColor(.purple)
                        .frame(maxWidth: 300, maxHeight: 60)
                    Image(systemName: "arrow.right")
                        .font(.system(size: 20))
                        .symbolVariant(.circle)

                }
                .background(.purple.opacity(0.2))
                .cornerRadius(15)
                
            })
    }
}

struct UserPannelView_Previews: PreviewProvider {
    static var previews: some View {
        UserPannelView(name: "Placeholder", id: 0)
    }
}
