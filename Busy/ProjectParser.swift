//
//  ProjectJSONParser.swift
//  Busy
//
//  Created by j w on 12/7/16.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation
import Firebase

class ProjectParser {
    
    class func getData(){
        
    }
    
    let userProjectsRef = FIRDatabase.database().reference().child("projects").child((FIRAuth.auth()?.currentUser?.uid)!)
    //let todayFilter = []
//    userProjectsRef.observeEvent(eventType: .value, with: { (snapshot) in
//
//        for project in snapshot.children { // all projects listed under FUID
//            if let deadline = project.value["projectDeadline"] {
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
//                let date = dateFormatter.dateFromString(deadline)
//                let currentDate = NSDate()
//    
//            }
//    }
//    })
}
//for attribute in (project as AnyObject).children.allObjects as! [FIRDataSnapshot] {
//    if attribute.key == "projectDeadline" {
//        let deadline == attribute.value!
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
//        let date = dateFormatter.dateFromString(dateString)
//        
//        
//    } else {continue}
//}
