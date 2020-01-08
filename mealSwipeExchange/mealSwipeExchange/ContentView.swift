//
//  ContentView.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 1/6/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI
import Firebase


struct ContentView: View {
    
    @EnvironmentObject var session: FirebaseSession
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
        HStack {
            Group {
            if (session.session != nil){
                Text("welcome!")
                Button(action: session.logOut){
                    Text("sign out")
                }
            }
            else{
                LoginView()
            }
            }.onAppear(perform: getUser)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FirebaseSession())
    }
}
