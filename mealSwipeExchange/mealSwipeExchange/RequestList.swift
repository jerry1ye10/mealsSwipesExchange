//
//  LandMarkList.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 1/9/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI

 

struct RequestList: View {
    
    @EnvironmentObject var session: FirebaseSession
    
    var profileButton: some View {
        Button(action: self.session.logOut) {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    var body: some View {
        Group{
            NavigationView{
                    List(session.users, id: \.uid) { user in
                        if user.diningHall != "" && user.diningHall != nil{
                            RequestRow(request: user.diningHall, name: user.firstName!)
                        }
                       }.navigationBarItems(trailing: profileButton)
            }
        }.onAppear(perform: session.getAllRequests)
    }
}


struct RequestList_Previews: PreviewProvider {
    static var previews: some View {
        RequestList()
    }
}
