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
    @State private var searchText = ""
    
    
    var profileButton: some View {
        HStack{
        if (session.session?.pairings.count != 0){
        Button(action: {self.showPairing = true}){
            Text("View your pairing!" )
        }
        }
        else{
            Text("Not yet paired!")
        }
        }
    }
    
    func searchUp(search: String, element: String) -> Bool{
        let searchUpper = search.uppercased()
        let elementUpper = element.uppercased()
        return searchUpper.contains(elementUpper)
    }
    var logoutButton: some View{
        Button(action: session.logOut){
            Text("Logout")
        }
    }
    var body: some View {
            NavigationView{
                    List {
                        TextField("Type your search",text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        ForEach(session.users) { user in
                            if (user.currentlyRequesting && (self.searchText == ""  || self.searchUp(search: user.diningHall as! String, element: self.searchText))){
                            ZStack{
                                RequestRow(request: user.diningHall, name: user.firstName!)
                                NavigationLink(destination: PairUpView(u: user)){
                                EmptyView()}.buttonStyle(PlainButtonStyle())
                                
                        }
                    }
                        }
                        if (session.session?.pairings.count != 0){
                        NavigationLink(destination: PairedUpRequest(user: self.session.findUser(id: ((self.session.session?.pairings[0])!))!),
                                       isActive: self.$showPairing)
                        { EmptyView() }
                            .frame(width: 0, height: 0)
                            .disabled(true)
                            .hidden()
                        }
                        }.navigationBarItems(leading:
                            logoutButton, trailing: profileButton
                            ).navigationBarBackButtonHidden(true).navigationBarTitle("Requests")
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
