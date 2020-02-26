//
//  PairUpView.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 2/22/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI

struct PairUpView: View {
    
    @EnvironmentObject var session: FirebaseSession
    var u: User
    @State var paired = false

    var body: some View {
            VStack{
                    Text("Hello" + (u.firstName ?? "World"))
                    Button(action: pair){
                    Text("Pair up!")
                    }.sheet(isPresented: $paired){
                        ContentView().environmentObject(self.session).edgesIgnoringSafeArea(.all)
                }
            }
    }
    func pair(){
        self.session.createPairing(otherId: u.uid)
        paired = true
    }
    
}

