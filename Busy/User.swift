//
//  User.swift
//  Busy
//
//  Created by j w on 11/24/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation

class User {
    let id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var role: String
    
    init(firstName: String, lastName: String, email: String, role: String) {
        self.id = NSUUID.init() as UUID
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.role = role
    }
}
