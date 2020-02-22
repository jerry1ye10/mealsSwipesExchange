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
            NavigationView{
                    List {
                        ForEach(session.users) { user in
                        if user.currentlyRequesting{
                            NavigationLink(destination: SwiftUIView()){
                                
                            
                            RequestRow(request: user.diningHall, name: user.firstName!)
                        }
                        }
                    }
            }.navigationBarItems(trailing: profileButton)
    }
}
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

struct RequestList_Previews: PreviewProvider {
    static var previews: some View {
        RequestList()
    }
}
