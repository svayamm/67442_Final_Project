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
    let startDate: NSDate
    var title: String
    var deadline: NSDate?
    var projectType: String
    var description: String
    var assignments: [Assignment]
    var githubRepo: String?
    var users: [[User]]
    var tasks: [Task]
    // Once again, storing tasks/assignments/users as whole objects in arrays
    // denormalising for ease of access in NoSQL database
    
    init(title: String, projectType: String, description: String) {
        self.id = NSUUID.init() as UUID
        self.startDate = NSDate.init()
        self.title = title
        self.projectType = projectType
        self.description = description
        self.assignments = []
        self.tasks = []
        self.users = [[],[]]
    }
    
    // mutating func addDeadline
    
    //mutating func addLeader - add User to first subarray of users
    
    // mutating func addMember - add User to second subarray of users
    
    // mutating func addGithubRepo - add String of form 'svayamm/67442_Final_Project'
    // validate githubRepo - check that above string is valid GitHub repo 
    // (i.e. check that "https://api.github.com/repos/\(GitHub Repo)" is valid - no 404 response)
    
    // func isComplete - checks if all tasks marked complete
    // func setComplete - iterates through tasks and sets each as complete
    
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
//    mutating func changeManager(manager: Int) {
//        self.manager = manager
//    }
    mutating func setDeadline(deadline: NSDate) {
        self.deadline = deadline
    }
    
}

extension Project: Equatable {
    static public func ==(lhs: Project, rhs: Project) -> Bool {
        return (lhs.id == rhs.id)
    }
}
