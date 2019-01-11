//
//  TaskEntity.swift
//  Dinner
//
//  Created by JORGE VAZQUEZ REQUEJO on 11/1/19.
//  Copyright © 2019 JORGE VAZQUEZ REQUEJO. All rights reserved.
//

import Foundation
import RealmSwift

class TaskEntity: Object{
    @objc dynamic var name = ""
    @objc dynamic var pay = ""
    @objc dynamic var date = Date()
    
    override static func primaryKey() -> String?{
        return "name"
    }
    
    convenience init(task: Task){
        self.init()
        self.name = task.name
        self.date = task.date
        self.pay = task.pay
    }
    
    func taskModel() -> Task{
        let model = Task()
        model.name = self.name
        model.date = self.date
        model.pay = self.pay
        
        return model
    }
}

