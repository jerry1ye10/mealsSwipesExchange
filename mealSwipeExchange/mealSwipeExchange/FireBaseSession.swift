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
    @Published var users = [User]()
    var db = Firestore.firestore()


//MARK: Functions

func listen() {
          _ =  Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                let docRef = self.db.collection("users").document(user.uid)

                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data()
                        self.session = User(uid: user.uid, firstName: dataDescription!["firstName"] as! String, lastName: dataDescription!["lastName"] as! String,phoneNumber: dataDescription!["phoneNumber"] as! String,year: dataDescription!["year"] as! String, diningHall: dataDescription!["diningHall"] as! String, hasSwipes: dataDescription!["hasSwipes"] as! Bool)
                    } else {
                        print("Document does not exist")
                    }
                }
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
    
    func requestMeal(diningHall: String){
        if (self.session != nil){
            let docRef = self.db.collection("users").document(self.session!.uid).setData(["diningHall": diningHall], merge: true)
            self.session?.diningHall = diningHall
        }
    }
    func cancelMeal(){
        let docRef = self.db.collection("users").document(self.session!.uid).setData(["diningHall": ""], merge: true)
        self.session?.diningHall = "" 
    }
    
    func getAllRequests(){
        db.collection("users").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        var dataDescription = document.data()
                        var u = User(uid: document.documentID,firstName: dataDescription["firstName"] as! String, lastName: dataDescription["lastName"] as! String,phoneNumber: dataDescription["phoneNumber"] as! String,year: dataDescription["year"] as! String, diningHall: dataDescription["diningHall"] as! String, hasSwipes: dataDescription["hasSwipes"] as! Bool)
                        self.users.append(u)
                    }
                }
        }
    }
}

