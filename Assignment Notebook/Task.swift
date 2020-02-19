//
//  Task.swift
//  Assignment Notebook
//
//  Created by Christina Ferrari on 1/22/20.
//  Copyright © 2020 TheLastAce. All rights reserved.
//

import UIKit

class Task: Codable {
    var name : String
    var subject :  String
    var dueDate : Int
    var description : String
    
    init(name: String, subject: String, dueDate: Int, description: String) {
       self.name = name
       self.subject = subject
       self.dueDate = dueDate
       self.description = description
    }
}
