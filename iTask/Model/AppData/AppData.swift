//
//  AppData.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-20.
//

import Foundation
import SwiftUI

// TODO: - Add Core Data
import CoreData

class AppData: ObservableObject {
    @Published var selectedTab: Tab = .tasks
    
    // MARK: - Tasks
    @Published var showingAddTask: Bool = false
    @Published var searchText: String = ""
    
    // MARK: - Settings
    @Published var darkMode: Bool = false
    @Published var debugMode: Bool = false
}
