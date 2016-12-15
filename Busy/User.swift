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
    let firebaseUID: String // Firebase provides a UID (well, technically Google does, upon authentication)
    var displayName: String
    var email: String
    var projects: [String] // Denormalising for easier access in Firebase's NoSQL database
    
    init(firebaseUID: String, displayName: String, email: String) {
        self.id = NSUUID.init() as UUID
        self.firebaseUID = firebaseUID
        self.displayName = displayName
        self.email = email
        self.projects = []
    }
    
    mutating func addProject(projectUUID: String) {
        self.projects.append(projectUUID)
}
    
//    mutating func changeFirstName(firstName: String) {
//        self.firstName = firstName
//    }
//    mutating func changeLastName(lastName: String) {
//        self.lastName = lastName
//    }
//    mutating func changeEmail(email: String) {
//        self.email = email
//    }
    // These functions are set by the authenticator (Google) upon login
}
extension User: Equatable {
    static public func ==(lhs: User, rhs: User) -> Bool {
        return (lhs.id == rhs.id)
    }
}
