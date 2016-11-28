//
//  Assignment.swift
//  Busy
//
//  Created by j w on 11/24/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation

struct Assignment {
    let id: UUID
    let project: Int
    let user: Int
    
    init(project: Int, user: Int) {
        self.id = NSUUID.init() as UUID
        self.project = project
        self.user = user
    }
}

extension Assignment: Equatable {
    static public func ==(lhs: Assignment, rhs: Assignment) -> Bool {
        return (lhs.id == rhs.id)
    }
}
