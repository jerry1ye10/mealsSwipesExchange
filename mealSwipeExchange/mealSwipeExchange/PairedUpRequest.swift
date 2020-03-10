//
//  PairedUpRequest.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 2/27/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI

struct PairedUpRequest: View {
    
    @EnvironmentObject var session: FirebaseSession
    @Environment(\.presentationMode) var presentation
    var user : User

    
    var body: some View {
        VStack{
        if (session.session?.pairings.count != 0){
            Image("mealSwipeExchange").resizable()
            .padding([.leading, .bottom, .trailing], 50.0)
            .scaledToFit()
            Text("Name: \(user.firstName!)  \(user.lastName!)")
                .font(.title)
                .padding(.bottom, 20.0)
            Text("Phone Number: \(user.phoneNumber!)").font(.title).padding(.bottom, 20.0)

            Text("Dining Hall: \(user.diningHall)").font(.title).padding(.bottom, 20.0)
            Text("Time: Lunch, 12:00 PM").font(.title)
            Button(action: cancel){
                Text("Cancel request!").foregroundColor(.red)
            }
            .padding(.top, 30.0)
        }
        else{
            Text("Your request has been canceled!")
        }
    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
            }
    
    func cancel(){
        let uid = self.session.session?.pairings[0]
        let token = session.users.first(where: {$0.uid == uid})?.token
        if let t = token as? String {
            session.sender.sendPushNotification(to: t, title: "Pairing Canceled", body: "You have been paired!")
        }
        session.removePairing(otherId: (uid)!)()

        session.session?.pairings.removeFirst()
        self.presentation.wrappedValue.dismiss()
        

        
    }
}


