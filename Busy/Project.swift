//
//  Project.swift
//  Busy
//
//  Created by j w on 11/24/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation

class Project {
    
    let id: UUID
    let creator: Int
    let startDate: NSDate
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
    
    func addAssignment(assignment: Assignment) {
        assignments.append(assignment)
    }
    func removeAssignment(assignment: Assignment) {
        for i in 1..<assignments.count{
            if assignment == assignments[i] {
                assignments.remove(at: i)
            }
        }
    }
    func editDescription(descr: String) {
        self.description = descr
    }
    func editProjectType(type: String) {
        self.projectType = type
    }
    
}
