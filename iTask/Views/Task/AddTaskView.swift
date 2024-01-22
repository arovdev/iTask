//
//  AddTaskView.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-20.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var isFavorite: Bool = false
    @State private var isImportant: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                // MARK: - Information Section
                InformationSection()
                
                // MARK: - Details Section
                DetailsSection()
                
                // MARK: - Add Button
                CButton(title: "Add") {
                    DataController().addTask(title: title, isImportant: isImportant, isFavorite: isFavorite, context: context)
                    dismiss()
                }
            }
            .navigationTitle("Add new task")
        }
    }
}

// MARK: - Extensions

extension AddTaskView {
    // Information Section
    func InformationSection() -> some View {
        Section(header: Text("Information")) {
            HStack(spacing: 10) {
                Image(systemName: "square.text.square")
                    .foregroundColor(.blue)
                
                TextField("Title", text: $title)
            }
        }
    }
    
    // Details Section
    func DetailsSection() -> some View {
        Section(header: Text("Details")) {
            HStack(spacing: 10) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Toggle("Favorite", isOn: $isFavorite)
                    .tint(.yellow)
            }
            
            HStack(spacing: 10) {
                Image(systemName: "calendar.badge.exclamationmark")
                    .foregroundColor(.red)
                Toggle("Important", isOn: $isImportant)
                    .tint(.red)
            }
        }
    }
    
    // Custom Button
    func CButton(title: String, onClick: @escaping () -> ()) -> some View {
        Button("\(title)") {
            onClick()
        }
    }
}
