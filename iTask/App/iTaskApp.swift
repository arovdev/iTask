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
    
    @State private var selectedTab: Tab = .tasks
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ZStack(alignment: .bottom) {
                    // MARK: - Tab View
                    TabView(selection: $appData.selectedTab) {
                        /// Tasks View
                        TasksView()
                            .tabItem {
                                Image(systemName: "list.triangle")
                            }
                            .tag(Tab.tasks)
                            .environment(\.managedObjectContext, dataController.container.viewContext)
                            .environmentObject(appData)
                        
                        /// Settings View
                        SettingsView()
                            .tabItem {
                                Image(systemName: "gearshape")
                            }
                            .tag(Tab.settings)
                            .environment(\.managedObjectContext, dataController.container.viewContext)
                            .environmentObject(appData)
                    }
                    
                    // MARK: - Custom Tab Bar
                    CustomTabBar(selectedTab: $appData.selectedTab)
                        .overlay {
                            // MARK: - FAB
                            FAB()
                        }
                }
                .onAppear {
                    UITabBar.appearance().isHidden = true
                }
                .environmentObject(appData)
            }
        }
    }
}
