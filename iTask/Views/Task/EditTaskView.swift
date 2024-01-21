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
                    TextField("\(title)", text: $title)
                        .onAppear {
                            title = task.title ?? ""
                        }
                    
                    Button("Edit") {
                        DataController().editTask(task: task, title: title, context: context)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Edit task")
        }
    }
}
