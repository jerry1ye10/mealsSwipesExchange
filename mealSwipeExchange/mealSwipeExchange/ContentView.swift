//
//  ContentView.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 1/6/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI
import Firebase
import UserNotifications


struct ContentView: View {
    
    @EnvironmentObject var session: FirebaseSession
    @State private var diningHall: String = ""
    @State var alert = false
    
    func setUp(){
        getUser()
        print(12)
        print(self.alert)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (success, error) in
            
            
           if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
            
            self.alert.toggle()
        }
    }
    
    func getUser(){
        session.listen()
    }
    
    var body: some View {
        HStack {
            Group {
            if (session.session != nil){
                if (session.session!.hasSwipes){
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
                    RequestList()
                }
            }
            else{
                LoginView()
            }
                }.onAppear(perform: setUp)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FirebaseSession())
    }
}
