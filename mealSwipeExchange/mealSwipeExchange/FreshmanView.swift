//
//  FreshmanView.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 3/8/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI

struct FreshmanView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @State private var diningHall: String = ""
    
    var body: some View {
        VStack{
        if session.session?.diningHall == ""{
            Text("No Request Made!")
            TextField("Enter Requested Dining Hall", text: $diningHall)
                Button(action: makeRequest) {
                Text("Request!")
            }
        }
        else {
            if session.session?.pairings.count != 0{
                Text("You are currently paired!")
            }
            Text("Current Request: \(diningHall)")
            Button(action: cancelRequest) {
                Text("Cancel Request")
            }
        }
        Button(action: self.session.logOut){
            Text("Log Out")
        }
    }
    }
    
    func makeRequest(){
        if !diningHall.isEmpty{
            self.session.requestMeal(diningHall: diningHall)
        }
    }
    
    func cancelRequest(){
        session.cancelMealRequest()
        
    }

}

struct FreshmanView_Previews: PreviewProvider {
    
    static var previews: some View {
        FreshmanView().environmentObject(FirebaseSession())

    }
    
}

