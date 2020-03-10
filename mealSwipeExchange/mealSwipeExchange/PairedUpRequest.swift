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
            Text(user.firstName!)
            Button(action: cancel){
                Text("Cancel request!")
            }
        }
        else{
            Text("Your request has been canceled!")
        }
    }
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


