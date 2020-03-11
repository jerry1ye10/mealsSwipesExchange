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
    var sender = PushNotificationSender()


//MARK: Functions

    func findUser(id: String) -> User?{
        print(id)
        for u in users{
            print(u.uid)
            if u.uid == id{
                return u
            }
        }
        return nil
    }
func listen() {
          _ =  Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                let docRef = self.db.collection("users").document(user.uid)

                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data()
                        self.session = User(uid: user.uid, firstName: dataDescription!["firstName"] as! String, lastName: dataDescription!["lastName"] as! String,phoneNumber: dataDescription!["phoneNumber"] as! String,year: dataDescription!["year"] as! String, diningHall: dataDescription!["diningHall"] as! String, hasSwipes: dataDescription!["hasSwipes"] as! Bool, pairings: dataDescription!["pairings"] as! [String])
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.userID = user.uid
                        UIApplication.shared.registerForRemoteNotifications()
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
    
    func createPairing(otherId: String){
        if (self.session != nil){
            let docRef = self.db.collection("users").document(self.session!.uid).updateData(["pairings": FieldValue.arrayUnion([otherId])])
            let docRef2 = self.db.collection("users").document(otherId).updateData(["pairings": FieldValue.arrayUnion([self.session!.uid])])
            self.db.collection("users").document(otherId).updateData(["currentlyRequesting":false])
            self.session?.pairings.append(otherId)
        }
        
    }
    
    func removePairing(otherId: String) -> () -> (){
        return {
        if (self.session != nil){
            let docRef = self.db.collection("users").document(self.session!.uid).updateData(["pairings": FieldValue.arrayRemove([otherId])])
            print(1000)
            let docRef2 = self.db.collection("users").document(otherId).updateData(["pairings": FieldValue.arrayRemove([self.session!.uid])])
        }
            self.db.collection("users").document(otherId).updateData(["currentlyRequesting": true])
    }
    }

func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
    Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func requestMeal(diningHall: String, time: Date){
        if (self.session != nil){
            let docRef = self.db.collection("users").document(self.session!.uid).setData(["diningHall": diningHall, "currentlyRequesting": true, "date": time], merge: true)
            self.session?.diningHall = diningHall
        }
    }
    func cancelMealRequest(){
        let docRef = self.db.collection("users").document(self.session!.uid).setData(["diningHall": "", "currentlyRequesting":false], merge: true)
        if (self.session?.pairings.count != 0){
            let id = self.session?.pairings[0]
            let dr = self.db.collection("users").document((self.session?.pairings[0])!).updateData(["pairings": FieldValue.arrayRemove([self.session!.uid])])
            let dr2 = self.db.collection("users").document(self.session!.uid).updateData(["pairings":FieldValue.arrayRemove([id])])
        }
        self.db.collection("users").document(session!.uid).updateData(["currentlyRequesting": false])
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
                        var dataDescription = document.data()
                        print(101)
                        if let lastName = dataDescription["lastName"] as? String, let firstName = dataDescription["firstName"] as? String, let phoneNumber = dataDescription["phoneNumber"] as? String, let year = dataDescription["year"] as? String, let diningHall = dataDescription["diningHall"] as? String, let hasSwipes = dataDescription["hasSwipes"] as? Bool, let pairings = dataDescription["pairings"] as? [String], let token = dataDescription["key"] as? String, let date = dataDescription["date"] as? Timestamp{
                            //let date = (dataDescription["date"]! as! Timestamp) ?? nil
                                
                                //.dateValue() ?? nil
                            var u = User(uid: document.documentID,firstName: firstName, lastName: lastName ,phoneNumber: phoneNumber,year: year, diningHall: diningHall, hasSwipes: hasSwipes, currentlyRequesting: self.checkcurrentlyRequesting(data: dataDescription) as! Bool, pairings: pairings, token: token, mealTime: date.dateValue() )
                            if (self.session?.uid == document.documentID){
                                print(123132131231231)
                                self.session = u
                            }
                        self.users.append(u)
                        }
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

