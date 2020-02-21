//
//  User.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 1/6/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import Foundation
struct User: Codable{
    
    var uid: String
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var year: String?
    var email: String?
    var diningHall = ""
    var hasSwipes = false

    
    /*init(uid: String, firstname: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.firstName = firstname
        
    }*/
}
