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
    
    var body: some View {
        Text("")
    }.onAppear(perform: session.getAllRequests)
}

struct RequestList_Previews: PreviewProvider {
    static var previews: some View {
        RequestList()
    }
}
