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

    var body: some View {
        VStack{
        Text("Hello" + (u.firstName ?? "World"))
        Button(action: self.session.createPairing(otherId: u.uid)){
            Text("Pair up!")
        }
        }
    }
}

