//
//  ContentView.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 1/6/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI
import Firebase


struct ContentView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @State private var diningHall: String = ""
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
        HStack {
            Group {
            if (session.session != nil){
                VStack{
                    if session.session?.diningHall == ""{
                        Text("No Request Made!")
                        TextField("Enter Requested Dining Hall", text: $diningHall)
                            Button(action: makeRequest) {
                            Text("Request!")
                        }
                    }
                    else {
                        Text("Current Request: " + session.session!.diningHall)
                        Button(action: cancelRequest) {
                            Text("Cancel Request")
                        }
                    }
                    Button(action: self.session.logOut){
                        Text("Log Out")
                    }
                }
            }
            else{
                LoginView()
            }
            }.onAppear(perform: getUser)
        }
    }
    func makeRequest(){
        if !diningHall.isEmpty{
            self.session.requestMeal(diningHall: diningHall)
        }
    }
    func cancelRequest(){
        session.cancelMeal()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FirebaseSession())
    }
}
