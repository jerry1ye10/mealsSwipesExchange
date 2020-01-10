//
//  snapShotExtensions.swift
//  mealSwipeExchange
//
//  Created by Jerry Ye on 1/8/20.
//  Copyright © 2020 Jerry Ye. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase


extension DocumentSnapshot{
    func decoded<Type: Decodable>() -> Type?{
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
            let object =  try JSONDecoder().decode(Type.self, from: jsonData)
            return object
        }
        catch let parseError as NSError{
            print("error")
            return nil
        }
    }
}
