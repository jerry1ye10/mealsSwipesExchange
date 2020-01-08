//
//  SignUp.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 1/6/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI

struct SignUp: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
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
                
            }
    }
}
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
