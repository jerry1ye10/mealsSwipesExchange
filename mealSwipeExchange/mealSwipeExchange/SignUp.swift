//
//  SignUp.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 1/6/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SignUp: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    @State private var year = 0
    @State private var receiveSwipes = 0
    let years = ["Freshman", "Sophomore", "Junior", "Senior"]
    
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Text("Email")
                    TextField("Enter Email Address", text: $email)
                }
                .padding()
                
                HStack {
                    Text("Password")
                    TextField("Enter Password", text: $password)
                }
                .padding()
                
                HStack {
                    Text("First Name")
                    TextField("Enter First Name", text: $firstName)
                }
                .padding()
                
                HStack {
                    Text("Last Name")
                    TextField("Enter Last Name", text: $lastName)
                }
                .padding()
                
                HStack {
                    Text("Phone Number")
                    TextField("Enter Phone Number", text: $phoneNumber)
                }
                .padding()
                
                HStack {
                    Picker(selection: $year, label: Text("Year")) {
                        
                        Text("Freshman").tag(0)
                        Text("Sophomore").tag(1)
                        Text("Junior").tag(2)
                        Text("Senior").tag(3)
                    }
                    .padding()
                    Picker(selection: $receiveSwipes, label: Text("Year")) {
                        
                        Text("Yes").tag(0)
                        Text("No").tag(1)
                    }
                }
                .padding()
                
                Button(action: signUp) {
                    Text("Sign Up")
                }
            }
        }
        .padding()
    }
    
    func signUp() {
        if !email.isEmpty && !password.isEmpty {
            session.signUp(email: email, password: password) { (result, error) in
                if error != nil {
                    print("Error")
                }
                else{
                    var giveSwipes = true
                    if self.receiveSwipes == 0{
                        giveSwipes = false
                    }
                    self.session.db.collection("users").document(Auth.auth().currentUser!.uid).setData(["firstName": self.firstName, "lastName": self.lastName, "phoneNumber": self.phoneNumber, "year": self.years[self.year], "email": self.email, "diningHall": "", "hasSwipes": giveSwipes ])
                }
                
            }
    }
}
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp().environmentObject(FirebaseSession())
    }
}
