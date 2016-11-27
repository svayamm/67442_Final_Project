//
//  Task.swift
//  Busy
//
//  Created by j w on 11/24/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation

struct Task {
    let id: UUID
    var name: String
    var description: String
    var dueDate: NSDate
    
    init(name: String, description: String, dueDate: NSDate) {
        self.id = NSUUID.init() as UUID
        self.name = name
        self.description = description
        self.dueDate = dueDate
    }
    mutating func changeName(name: String) {
        self.name = name
    }
    mutating func changeDescription(description: String) {
        self.description = description
    }
    mutating func changeDueDate(dueDate: NSDate) {
        self.dueDate = dueDate
    }
}

extension Task: Equatable {
    static public func ==(lhs: Task, rhs: Task) -> Bool {
        return (lhs.id == rhs.id)
    }
}
