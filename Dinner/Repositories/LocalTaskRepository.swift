//
//  LocalTaskRepository.swift
//  Dinner
//
//  Created by JORGE VAZQUEZ REQUEJO on 11/1/19.
//  Copyright © 2019 JORGE VAZQUEZ REQUEJO. All rights reserved.
//

import UIKit
import RealmSwift

class LocalTaskRepository: Repository {
    
    func getAll() -> [Task] {
        var tasks: [Task] = []
        do{
            let entities = try Realm().objects(TaskEntity.self).sorted(byKeyPath: "date",
                                                                       ascending: false)
            for entity in entities{
                let model = entity.taskModel()
                tasks.append(model)
            }
        }
        catch let error as NSError{
            print("Error getAll Tasks: ", error.description)
        }
        return tasks
    }
    
    func get(identifier: String) -> Task? {
        do {
            let realm = try Realm()
            if let entity = realm.objects(TaskEntity.self).filter("name == %@", identifier).first{
                let model = entity.taskModel()
                return model
            }
        }
        catch {
            return nil
        }
        return nil
    }
    
    func create(a: Task) -> Bool {
        do {
            let realm = try Realm()
            let entity = TaskEntity(task: a)
            try realm.write {
                realm.add(entity, update: true)
            }
        }
        catch{
            return false
        }
        return true
    }
    
    func update(a: Task) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                let entityToDelete = realm.objects(TaskEntity.self).filter("name == %@", a.name)
                realm.delete(entityToDelete)
                let entity = TaskEntity(task: a)
                realm.add(entity, update: true)
            }
        }
        catch {
            return false
        }
        return true
    }
    
    func delete(a: Task) -> Bool {
        do {
            let realm = try Realm()
            try realm.write {
                let entityToDelete = realm.objects(TaskEntity.self).filter("name == %@", a.name)
                realm.delete(entityToDelete)
            }
        }
        catch {
            return false
        }
        return true
    }
    
}

