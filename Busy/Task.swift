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
    let projectID: String
    var complete: Bool
    var name: String
    var description: String
    var dueDate: NSDate
    // include priority variable?
    
    init(project: Project, name: String, description: String, dueDate: NSDate) {
        self.id = NSUUID.init() as UUID
        self.projectID = project.id.uuidString
        self.name = name
        self.description = description
        self.dueDate = dueDate
        self.complete = false // default: false
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
    
    mutating func setComplete() {
        self.complete = true
    }
    
    func isComplete() -> Bool {
        return self.complete
    }
}

extension Task: Equatable {
    static public func ==(lhs: Task, rhs: Task) -> Bool {
        return (lhs.id == rhs.id)
    }
}
