//
//  TaskData.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-20.
//

import Foundation
import SwiftUI

class TaskData: ObservableObject {
    @Published var debug: Bool = false
    @Published var searchText: String = ""
    
    @Published var darkMode: Bool = false
}