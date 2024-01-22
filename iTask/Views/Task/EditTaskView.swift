//
//  EditTaskView.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-20.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.dismiss) var dismiss
    
    var task: FetchedResults<Task>.Element
    
    @State private var title: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    // MARK: - Information Section
                    InformationSection()
                    
                    // MARK: - Change Button
                    CButton(title: "Change") {
                        DataController().editTask(task: task, title: title, context: context)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Edit task")
        }
    }
}

extension EditTaskView {
    // Information Section
    func InformationSection() -> some View {
        Section(header: Text("Information")) {
            HStack(spacing: 10) {
                Image(systemName: "square.text.square")
                    .foregroundColor(.blue)
                
                TextField("\(title)", text: $title)
                    .onAppear {
                        title = task.title ?? ""
                    }
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
