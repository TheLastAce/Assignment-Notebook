//
//  MasterViewController.swift
//  Assignment Notebook
//
//  Created by Christina Ferrari on 1/21/20.
//  Copyright © 2020 TheLastAce. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {
    
    var tasks = [Task]()
    var detailViewController: DetailViewController? = nil
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        if let savedData = defaults.object(forKey: "data") as? Data {
            if let decoded = try? JSONDecoder().decode([Task].self, from: savedData) {
                tasks = decoded
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        tableView.reloadData()
        saveData()
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        let alert = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Assignment"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Subject"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "DueDate"
            textField.keyboardType = .numberPad
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Description"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        let insertAction = UIAlertAction(title: "Add", style: .default) { (action) in
            // title = assignment
            let assignmentTextField = alert.textFields![0] as UITextField
            let subjectTextField = alert.textFields![1] as UITextField
            let dueDateTextField = alert.textFields![2] as UITextField
            let descriptionTextField = alert.textFields![3] as UITextField
            if let dueDate = Int(dueDateTextField.text!) {
                let task = Task(name: assignmentTextField.text!,
                                subject: subjectTextField.text!,
                                dueDate: dueDate,
                                description: descriptionTextField.text!)
                self.tasks.append(task)
                self.tableView.reloadData()
                self.saveData()
            }
        }
        alert.addAction(insertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            defaults.set(encoded, forKey: "data")
        }
    }
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = tasks[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let object = tasks[indexPath.row]
        cell.textLabel!.text = object.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        } else if editingStyle == .insert {
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let objectToMove = tasks.remove(at: sourceIndexPath.row)
        tasks.insert(objectToMove, at: destinationIndexPath.row)
        saveData()
    }
}

