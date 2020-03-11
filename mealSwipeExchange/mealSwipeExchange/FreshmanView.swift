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
    @State private var showPairing = false
    @State private var currentDate = Date()
    
    var body: some View {
        
        VStack{
            Image("mealSwipeExchange")
            .resizable()
                .padding([.leading, .bottom, .trailing], 50.0)
                .scaledToFit()
        if session.session?.diningHall == ""{
            Text("No Request Made!")
            TextField("Enter Requested Dining Hall", text: $diningHall)
                .padding(.leading, 100.0)
            Text("Pick a time")
            DatePicker("", selection: $currentDate, displayedComponents: [.date, .hourAndMinute])
            .labelsHidden()
                Button(action: makeRequest) {
                Text("Request!")
                    }.foregroundColor(.red)
        }
        else {
            if session.session?.pairings.count != 0{
                Button(action: {self.showPairing.toggle()}){
                    Text("View your current pairing")

                }.foregroundColor(.red)
            }
            Text("Current Request: \(diningHall) at \(currentDate)")
            Button(action: cancelRequest) {
                Text("Cancel Request")
            }.foregroundColor(.red)
        }
        Button(action: self.session.logOut){
            Text("Log Out")
        }.foregroundColor(.red)
    }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
        .background(Color.blue.edgesIgnoringSafeArea(.all))
        .sheet(isPresented: $showPairing) {
            EmptyView()
        }
        
        

    }
    func makeRequest(){
        if !diningHall.isEmpty{
            self.session.requestMeal(diningHall: diningHall, time: currentDate)
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

