//
//  NewViewController.swift
//  Busy
//
//  Created by Svayam Mishra on 13/11/2016.
//  Copyright © 2016 Svayam Mishra. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import SwiftForms

class NewFormViewController: FormViewController {
    
    let currentFUID = FIRAuth.auth()?.currentUser?.uid
    
    
    // From examplar code provided by SwiftForms
    struct Static {
        static let title = "title"
        static let deadline = "deadline"
        static let button = "button"
        static let repo = "repo"
        static let description = "description"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(NewFormViewController.submit(_:)))
    }
    
    // MARK: Actions
    
    func submit(_: UIBarButtonItem!) {
        
        let message = self.form.formValues().description
//        
//        print(self.form.formValues()["title"])
        
        let alertController = UIAlertController(title: "Form output", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        
        alertController.addAction(cancel)
        
        //self.present(alertController, animated: true, completion: nil)
        
        weak var weakSelf = self // required to fix 'implicit use of self in closure' error
        weakSelf?.performSegue(withIdentifier: "NewSoloToDetail", sender: self)
    }
    
    // MARK: New Project Form interface, using SwiftForms lib
    
    fileprivate func loadForm() {
        
        let form = FormDescriptor(title: "New Solo Project Form")
        
        let section1 = FormSectionDescriptor(headerTitle: "Project Information:", footerTitle: nil)
        
        var row = FormRowDescriptor(tag: Static.title, type: .text, title: "Project Title")
        row.configuration.cell.appearance = ["textField.placeholder" : "Project Name" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        row.configuration.cell.required = true
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.description, type: .multilineText, title: "Description")
        row.configuration.cell.appearance = ["textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        row.configuration.cell.required = true
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.deadline, type: .date, title: "Due Date")
        row.configuration.cell.showsInputToolbar = true
        row.configuration.cell.required = true
        section1.rows.append(row)
        
        let section2 = FormSectionDescriptor(headerTitle: "Optional input:", footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.repo, type: .text, title: "GitHub Repo")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. profh/StarTrekSwift" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        
        let section3 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.button, type: .button, title: "Cancel")
        row.configuration.button.didSelectClosure = { _ in
            self.view.endEditing(true)
//            // Create a new "NewProjectTypes" instance.
//            let storyboard = UIStoryboard(name: "NewProjectTypes", bundle: nil)
//            
//            // Create an instance of the storyboard's initial view controller.
            // change to correct identifier
//            let controller = storyboard.instantiateViewController(withIdentifier: "InitialController") as UIViewController
//            
//            // Display the new view controller.
//             weak var weakSelf = self // required to fix 'implicit use of self in closure' error
//            weakSelf?.present(controller, animated: true, completion: nil)

        }
        section3.rows.append(row)
        
        form.sections = [section1, section2, section3]
        
        self.form = form
    }

    func createSoloProject() -> [String: Any]{
        
        // create new node on 'projects' directory, with user's FirebaseUID string as key (denormalisation!)
        let filledForm = self.form.formValues()
//        guard let projectTitle = filledForm["title"] else {print("Form field not set: title"); return}
//        guard let description = filledForm["description"] else {print("Form field not set: description"); return}
//        guard let projectDeadline = filledForm["deadline"] else {print("Form field not set: deadline"); return}
//        guard let repoLink = filledForm["repo"] else {print("Form field not set: repo"); return}
        // Auto-generated values
        let UUID = NSUUID.init().uuidString
        let projectType = "solo"
        var adminList = [] as [String] // add user FUID
        adminList.append(currentFUID!)
        var userList = [] as [[String]]
        userList.append(adminList)
        var complete = 0
        var assignments = [] as [String] // add assignment UUIDstring
        var tasks = [] as [String]
        // User-generated values
        let projectTitle = filledForm["title"]
        let description = filledForm["description"]
        // converting NSDate to String
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        var convertedDate = dateFormatter.string(from: filledForm["deadline"] as! Date)
        let projectDeadline = convertedDate
        let repoLink = filledForm["repo"]
        let soloProjectDict = ["projectTitle":projectTitle!,"description": description!, "projectDeadline": projectDeadline as AnyObject, "repoLink": repoLink!, "id": UUID as AnyObject, "type":projectType as AnyObject, "users":userList as AnyObject, "assignments":assignments as AnyObject, "tasks":tasks as AnyObject, "complete":complete as AnyObject] as [String : AnyObject]
        // dictionary of project info created, to be passed into database
        return soloProjectDict
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewSoloToDetail"
        {
            if let destinationVC = segue.destination as?  DetailsViewController {
                // INCLUDE OTHER MODEL PROPERTIES; TRIAL ONLY
                let dict = self.createSoloProject()
                let projectID = dict["id"] as! String
                let userProjectsRef = FIRDatabase.database().reference().child("projects").child(currentFUID!).child(projectID)
                userProjectsRef.updateChildValues(dict, withCompletionBlock: {
                    (err, ref) in
                    
                    if err != nil {
                        print(err ?? "Error could not be cast as string")
                        return}
                    
                    print("Successfully saved solo project in FIR Database")
                })
                destinationVC.projectUUID = projectID
            }
        }
    }
}
