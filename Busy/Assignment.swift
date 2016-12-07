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
    let projectID: String // Project.id can be retrieved as a uuidString
    let taskID: String
    var userID: String?
    var complete: Bool // isComplete boolean flag
    
    
    init(project: Project, task: Task, user: User) {
        self.id = NSUUID.init() as UUID
        self.projectID = project.id.uuidString
        self.taskID = task.id.uuidString
        self.userID = user.id.uuidString
        self.complete = false
    }
    
    mutating func setComplete() {
        self.complete = true
    }
    
    func isComplete() -> Bool {
        return self.complete
    }

}


extension Assignment: Equatable {
    static public func ==(lhs: Assignment, rhs: Assignment) -> Bool {
        return (lhs.id == rhs.id)
    }
}
