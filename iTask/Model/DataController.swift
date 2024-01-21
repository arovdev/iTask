//
//  DataController.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-20.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "iTaskModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load the data: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!")
        } catch {
            print("Error while saving data: \(error)")
        }
    }
    
    func addTask(title: String, context: NSManagedObjectContext) {
        let task = Task(context: context)
        task.id = UUID()
        task.title = title
        task.date = Date()
        
        save(context: context)
    }
    
    func editTask(task: Task, title: String, context: NSManagedObjectContext) {
        task.title = title
        task.date = Date()
        
        save(context: context)
    }
    
    func favoriteTask(task: Task, context: NSManagedObjectContext) {
        task.isFavorite.toggle()
        
        save(context: context)
    }

    func doneTask(task: Task, context: NSManagedObjectContext) {
        task.isDone.toggle()
        task.isFavorite = false
        
        save(context: context)
    }
    
    func deleteTask(task: Task, context: NSManagedObjectContext) {
        context.delete(task)
        save(context: context)
    }
}
