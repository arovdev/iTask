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
    @StateObject private var appData = AppData()
    
    var body: some Scene {
        WindowGroup {
            // MARK: - Tab Bar
            TabView {
                TasksView()
                    .tabItem {
                        Image(systemName: "list.triangle")
                    }
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(appData)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape")
                    }
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(appData)
            }
        }
    }
}
