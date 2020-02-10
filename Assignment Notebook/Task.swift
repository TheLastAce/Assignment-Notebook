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
    var discription : String
    
    init(name: String, subject: String, dueDate: Int, discription: String) {
       self.name = name
       self.subject = subject
       self.dueDate = dueDate
       self.discription = discription
    }


}
