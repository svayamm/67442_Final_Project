//
//  UserJSONParser.swift
//  Busy
//
//  Created by Svayam Mishra on 06/12/2016.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation
import Firebase

class UserParser {
    
    let rootRef = FIRDatabase.database().reference()
    
    func accessUserNode() {
        let usersRef = rootRef.child("users")
        let currentUID = FIRAuth.auth()?.currentUser?.uid
  //      let

    }
    
    func updateSingleAttribute(attribute: String)
    
//    class func parse(url: String){
//        let theURL: NSURL = NSURL(string: url)!
//        
//        let data = NSData(contentsOf: theURL as URL)!
//        let swiftyjson = JSON(data: data as Data)
//        
////        if let owner_login = swiftyjson["items"][0]["owner"]["login"].string {
////            print(owner_login)
//        }

}
