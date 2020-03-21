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
    @Environment(\.presentationMode) var presentation
    
    
    var body: some View {
            VStack{
                if (self.session.session?.pairings.count != 0){
                    Text("You can only pair with one person at a time as of now.").foregroundColor(.red)
                }
                    Text("Hello" + (u.firstName ?? "World"))
                    Button(action: pair){
                    Text("Pair up!")
                    }
            }
    }
    func pair(){
        if (session.session?.pairings.count != 0){
            return
        }
        self.session.createPairing(otherUser: u)
        let token = session.users.first(where: {$0.uid == u.uid})?.token
        if let t = token as? String {
            session.sender.sendPushNotification(to: t, title: "Pairing Made", body: "You have been paired!")
        }
        self.presentation.wrappedValue.dismiss()
    }
    
}

