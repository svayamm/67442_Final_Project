//
//  Task.swift
//  Busy
//
//  Created by j w on 11/24/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation

class Task {
    var name: String
    var description: String
    var dueDate: NSDate
    
    init(name: String, description: String, dueDate: NSDate) {
        self.name = name
        self.description = description
        self.dueDate = dueDate
    }
}
