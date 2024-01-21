// DataController.swift
// iTask
//
// Created by Arthur Reshetnyak on 2024-01-20.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    // MARK: - Properties
    
    let container = NSPersistentContainer(name: "iTaskModel")
    
    // MARK: - Initialization
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load the data: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Core Data Operations
    
    /// Saves changes to the Core Data context.
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved!")
        } catch {
            print("Error while saving data: \(error)")
        }
    }
    
    /// Adds a new task to the Core Data context.
    func addTask(title: String, context: NSManagedObjectContext) {
        let task = Task(context: context)
        task.id = UUID()
        task.title = title
        task.date = Date()
        
        save(context: context)
    }
    
    /// Edits an existing task in the Core Data context.
    func editTask(task: Task, title: String, context: NSManagedObjectContext) {
        task.title = title
        task.date = Date()
        
        save(context: context)
    }
    
    /// Toggles the 'isFavorite' property of a task in the Core Data context.
    func favoriteTask(task: Task, context: NSManagedObjectContext) {
        task.isFavorite.toggle()
        
        save(context: context)
    }

    /// Toggles the 'isDone' property of a task in the Core Data context.
    func doneTask(task: Task, context: NSManagedObjectContext) {
        task.isDone.toggle()
        task.isFavorite = false
        
        save(context: context)
    }
    
    /// Deletes a task from the Core Data context.
    func deleteTask(task: Task, context: NSManagedObjectContext) {
        context.delete(task)
        save(context: context)
    }
}
