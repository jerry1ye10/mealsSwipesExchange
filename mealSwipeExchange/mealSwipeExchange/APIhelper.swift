//
//  APIhelper.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 1/6/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FirebaseSession: ObservableObject {

//MARK: Properties
@Published var session: User?
@Published var isLoggedIn: Bool?

var ref: DatabaseReference = Database.database().reference(withPath: "\(String(describing: Auth.auth().currentUser?.uid ?? "Error"))")

//MARK: Functions

func listen() {
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, displayName: user.displayName, email: user.email)
            }
        }
    }

func logIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
    Auth.auth().signIn(withEmail: email, password: password, completion: handler)
}

func logOut() {
        try! Auth.auth().signOut()
        self.isLoggedIn = false
        self.session = nil

}

func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
    Auth.auth().createUser(withEmail: email, password: password, completion: handler)
}

}
