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
                        self.session = User(uid: user.uid, firstName: dataDescription!["firstName"] as! String, lastName: dataDescription!["lastName"] as! String,phoneNumber: dataDescription!["phoneNumber"] as! String,year: dataDescription!["year"] as! String, diningHall: dataDescription!["diningHall"] as! String, hasSwipes: dataDescription!["hasSwipes"] as! Bool, pairings: dataDescription!["pairings"] as! [String])
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
    
    func createPairing(otherId: String) -> () ->(){
        return{
        if (self.session != nil){
            let docRef = self.db.collection("users").document(self.session!.uid).updateData(["pairings": FieldValue.arrayUnion([otherId])])
            let docRef2 = self.db.collection("users").document(otherId).updateData(["pairings": FieldValue.arrayUnion([self.session!.uid])])
            self.session?.pairings.append(otherId)
        }
        }
    }
    
    func removePairing(otherId: String) -> () -> (){
        return {
        if (self.session != nil){
            let docRef = self.db.collection("users").document(self.session!.uid).updateData(["pairings": FieldValue.arrayRemove([otherId])])
            let docRef2 = self.db.collection("users").document(otherId).updateData(["pairings": FieldValue.arrayRemove([self.session!.uid])])
        }
    }
    }

func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
    Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func requestMeal(diningHall: String){
        if (self.session != nil){
            let docRef = self.db.collection("users").document(self.session!.uid).setData(["diningHall": diningHall, "currentlyRequesting": true], merge: true)
            self.session?.diningHall = diningHall
        }
    }
    func cancelMeal(){
        let docRef = self.db.collection("users").document(self.session!.uid).setData(["diningHall": ""], merge: true)
        self.session?.diningHall = "" 
    }
    
    init(){
        self.users = [User]() 
        db.collection("users").addSnapshotListener { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.users = [User]() 
                    for document in querySnapshot!.documents {
                        print(document)
                        var dataDescription = document.data()
                        print(type(of: dataDescription))
                        print(dataDescription["firstName"] as! String)
                        print(dataDescription["year"] as! String)
                        print(dataDescription["hasSwipes"] as! Bool)
                        print(dataDescription["lastName"] as! String); print(dataDescription["pairings"])
                        var u = User(uid: document.documentID,firstName: dataDescription["firstName"] as! String, lastName: dataDescription["lastName"] as! String,phoneNumber: dataDescription["phoneNumber"] as! String,year: dataDescription["year"] as! String, diningHall: dataDescription["diningHall"] as! String, hasSwipes: dataDescription["hasSwipes"] as! Bool, currentlyRequesting: self.checkcurrentlyRequesting(data: dataDescription) as! Bool, pairings: dataDescription["pairings"] as! [String])
                        self.users.append(u)
                    }
                }
        }
    }
   func checkcurrentlyRequesting(data: Dictionary<String,Any>) -> Bool {
    if data["currentlyRequesting"] == nil{
        return false
    }
    return (data["currentlyRequesting"] as! Bool)
        
    }
}

