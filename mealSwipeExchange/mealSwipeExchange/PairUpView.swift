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
                    Text("Hello" + (u.firstName ?? "World"))
                    Button(action: pair){
                    Text("Pair up!")
                    }
            }
    }
    func pair(){
        self.session.createPairing(otherId: u.uid)
        let sender = PushNotificationSender()
        sender.sendPushNotification(to: "eQDjyQghin4:APA91bEivZg7LIM4xEY0E5Km4Zhe3-WJreKpVRzH4RXUVdsYHk3NERMstqBMGl2bDa7Rd95WTRKDZf7NFONpERY0bkF41xW2QSj_P6LTjrD_gTOGynhy2wG_jiD6ej0fmT90-XRFcqaN", title: "Notification title", body: "Notification body")
        self.presentation.wrappedValue.dismiss()
    }
    
}

