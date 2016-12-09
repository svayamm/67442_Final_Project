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
    
    // From examplar code provided by SwiftForms
    struct Static {
        static let nameTag = "name"
        static let passwordTag = "password"
        static let lastNameTag = "lastName"
        static let jobTag = "job"
        static let emailTag = "email"
        static let URLTag = "url"
        static let phoneTag = "phone"
        static let enabled = "enabled"
        static let check = "check"
        static let segmented = "segmented"
        static let picker = "picker"
        static let birthday = "birthday"
        static let categories = "categories"
        static let button = "button"
        static let stepper = "stepper"
        static let slider = "slider"
        static let textView = "textview"
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
        
        let alertController = UIAlertController(title: "Form output", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: New Project Form interface, using SwiftForms lib
    
    fileprivate func loadForm() {
        
        let form = FormDescriptor(title: "New Project Form")
        
        let section1 = FormSectionDescriptor(headerTitle: "Project Information:", footerTitle: nil)
        
        var row = FormRowDescriptor(tag: Static.nameTag, type: .text, title: "Project Title")
        row.configuration.cell.appearance = ["textField.placeholder" : "Project Name" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        row.configuration.cell.appearance = ["textField.placeholder" : placeholder() as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        row.configuration.cell.required = true
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.textView, type: .multilineText, title: "Description")
        row.configuration.cell.required = true
        section1.rows.append(row)
        
        let section2 = FormSectionDescriptor(headerTitle: "Optional input:", footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.birthday, type: .date, title: "Due Date")
        row.configuration.cell.showsInputToolbar = true
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.textView, type: .text, title: "GitHub Repo")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. profh/StarTrekSwift" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        
        let section3 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.button, type: .button, title: "Dismiss")
        row.configuration.button.didSelectClosure = { _ in
            self.view.endEditing(true)
        }
        section3.rows.append(row)
        
        form.sections = [section1, section2, section3]
        
        self.form = form
    }
    
    func placeholder() -> String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ipsum ligula, finibus eget risus in, lacinia fermentum ligula. Aenean id ultricies dolor. Sed venenatis magna eu est tempus rhoncus at eu augue."
    }
}
