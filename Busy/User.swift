//
//  User.swift
//  Busy
//
//  Created by j w on 11/24/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation

struct User {
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
    
    mutating func changeFirstName(firstName: String) {
        self.firstName = firstName
    }
    mutating func changeLastName(lastName: String) {
        self.lastName = lastName
    }
    mutating func changeEmail(email: String) {
        self.email = email
    }
    mutating func changeRole(role: String) {
        self.role = role
    }
}
extension User: Equatable {
    static public func ==(lhs: User, rhs: User) -> Bool {
        return (lhs.id == rhs.id)
    }
}
