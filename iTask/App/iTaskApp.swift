//
//  iTaskApp.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-20.
//

import SwiftUI

@main
struct iTaskApp: App {
    @State private var dataController = DataController()
    @StateObject private var taskData = TaskData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(taskData)
        }
    }
}
