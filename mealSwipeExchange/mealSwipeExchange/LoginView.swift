//
//  LoginView.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 1/6/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI
import UIKit

struct LoginView: View {
    
    //MARK: Properties
    @State var email: String = ""
    @State var password: String = ""
    
    @EnvironmentObject var session: FirebaseSession
    
    var body: some View {
        NavigationView{
        VStack(spacing: 20) {
            Text("Sign In")
            TextField("Email", text: $email)
            
            SecureField("Password", text: $password)
            Button(action: logIn) {
                Text("Sign In")
            }
            .padding()
            
            NavigationLink(destination: SignUp()) {
                Text("Sign Up")
            }
        }
        }
    .padding()
    }
    
    //MARK: Functions
    func logIn() {
        session.logIn(email: email, password: password) { (result, error) in
            if error != nil {
                print("Error")
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
