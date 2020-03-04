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

    
    var body: some View {
        ZStack{
        if (session.session?.pairings.count != 0){
            Text("Hello " + (self.session.findUser(id: (self.session.session?.pairings[0])!)?.firstName!)!)
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
        session.removePairing(otherId: (self.session.session?.pairings[0])!)()
        session.session?.pairings.removeFirst()
        self.presentation.wrappedValue.dismiss()
        

        
    }
}


