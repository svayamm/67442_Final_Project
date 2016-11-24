//
//  Project.swift
//  Busy
//
//  Created by j w on 11/24/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation

class Project {
    
    let creator: Int
    let startDate: NSDate
    var projectType: String
    var description: String
    var manager: Int
    var assignments: [Assignment]
    var tasks: [Task]
    
    init(creator: Int, projectType: String, description: String, manager: Int) {
        self.creator = creator
        self.startDate = NSDate.init()
        self.projectType = projectType
        self.description = description
        self.manager = manager
        self.assignments = []
        self.tasks = []
    }
    
}
