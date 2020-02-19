//
//  DetailViewController.swift
//  Assignment Notebook
//
//  Created by Christina Ferrari on 1/21/20.
//  Copyright © 2020 TheLastAce. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    //task = city
    //subject = state
    //dueDate = population
    
    var detailItem: Task? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item
        if let task = self.detailItem {
            if taskTextField != nil {
                taskTextField.text = task.name
                subjectTextField.text = task.subject
                dueDateTextField.text = String(task.dueDate)
                descriptionTextField.text = task.description
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let task = self.detailItem {
            task.name = taskTextField.text!
            task.subject = subjectTextField.text!
            task.dueDate = Int(dueDateTextField.text!)!
            task.description = (descriptionTextField.text!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
}

