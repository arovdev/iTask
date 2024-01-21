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
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    TextField("Title", text: $title)
                    
                    Button("Add") {
                        DataController().addTask(title: title, context: context)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add new task")
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
    }
}
