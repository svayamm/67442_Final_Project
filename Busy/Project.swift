//
//  Project.swift
//  Busy
//
//  Created by j w on 11/24/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation

struct Project {
    
    let id: UUID
    let creator: Int
    let startDate: NSDate
    var deadline: NSDate?
    var projectType: String
    var description: String
    var manager: Int
    var assignments: [Assignment]
    var tasks: [Task]
    
    init(creator: Int, projectType: String, description: String, manager: Int) {
        self.id = NSUUID.init() as UUID
        self.creator = creator
        self.startDate = NSDate.init()
        self.projectType = projectType
        self.description = description
        self.manager = manager
        self.assignments = []
        self.tasks = []
    }
    
    mutating func addAssignment(assignment: Assignment) {
        assignments.append(assignment)
    }
    mutating func removeAssignment(assignment: Assignment) {
        for i in 1..<assignments.count{
            if assignment == assignments[i] {
                assignments.remove(at: i)
            }
        }
    }
    mutating func addTask(task: Task) {
        tasks.append(task)
    }
    mutating func removeTask(task: Task) {
        for i in 1..<tasks.count{
            if task == tasks[i] {
                tasks.remove(at: i)
            }
        }
    }
    mutating func editDescription(descr: String) {
        self.description = descr
    }
    mutating func editProjectType(type: String) {
        self.projectType = type
    }
    mutating func changeManager(manager: Int) {
        self.manager = manager
    }
    mutating func setDeadline(deadline: NSDate) {
        self.deadline = deadline
    }
    
}

extension Project: Equatable {
    static public func ==(lhs: Project, rhs: Project) -> Bool {
        return (lhs.id == rhs.id)
    }
}
