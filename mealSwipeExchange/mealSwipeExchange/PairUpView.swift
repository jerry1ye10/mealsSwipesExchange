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
        self.presentation.wrappedValue.dismiss()
    }
    
}

