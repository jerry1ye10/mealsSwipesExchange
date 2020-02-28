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
    @State private var showPairing = false
    
    var profileButton: some View {
        Button(action: {self.showPairing = true}){
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .accessibility(label: Text("User Profile"))
                .padding()
        }
    }
    var logoutButton: some View{
        Button(action: session.logOut){
            Text("Logout")
        }
    }
    var body: some View {
            NavigationView{
                    List {
                        ForEach(session.users) { user in
                        if user.currentlyRequesting{
                            ZStack{
                                RequestRow(request: user.diningHall, name: user.firstName!)
                                NavigationLink(destination: PairUpView(u: user)){
                                EmptyView()}.buttonStyle(PlainButtonStyle())
                                
                        }
                    }
                        }
                        NavigationLink(destination: PairedUpRequest(),
                                       isActive: self.$showPairing)
                        { EmptyView() }
                            .frame(width: 0, height: 0)
                            .disabled(true)
                            .hidden()
                        }.navigationBarItems(trailing:
                            HStack{
                                profileButton
                                logoutButton
                            }).navigationBarBackButtonHidden(true).navigationBarTitle("Requests")
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
