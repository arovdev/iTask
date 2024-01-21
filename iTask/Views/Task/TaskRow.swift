//
//  TaskRow.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-20.
//

import SwiftUI

struct TaskRow: View {
    @EnvironmentObject var taskData: TaskData
    @Environment(\.managedObjectContext) var context
    
    var task: Task
    
    @Binding var selectedTask: Task?

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.title ?? "No Title")
                    Text("\(task.date?.formatted() ?? "No date")")
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: task.isDone ? "circle.inset.filled" : (task.isFavorite ? "star.fill" : "circle"))
                    .imageScale(.large)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        if !task.isFavorite {
                            DataController().doneTask(task: task, context: context)
                        } else {
                            DataController().favoriteTask(task: task, context: context)
                        }
                    }
            }
            
            /// DEBUG SECTION
            if taskData.debug {
                VStack(alignment: .leading){
                    Text("""
                    {
                        "id": "\(task.id?.uuidString ?? "No ID")",
                        "title": "\(task.title ?? "No Title")",
                        "isDone": \(task.isDone ? "true" : "false"),
                        "isFavorite": \(task.isFavorite ? "true" : "false"),
                    }
                    """)
                }
                .foregroundColor(.gray)
            }
        }
        .swipeActions(edge: .leading) {
            switch (task.isDone, task.isFavorite) {
            case (false, false):
                Button {
                    DataController().doneTask(task: task, context: context)
                } label: {
                    Image(systemName: "circle")
                }
                .tint(.blue)
                
                Button {
                    DataController().favoriteTask(task: task, context: context)
                } label: {
                    Image(systemName: "star")
                }
                .tint(.green)

            case (true, false):
                Button {
                    DataController().doneTask(task: task, context: context)
                } label: {
                    Image(systemName: "circle.slash")
                }
                .tint(.blue)

            case (false, true):
                Button {
                    DataController().favoriteTask(task: task, context: context)
                } label: {
                    Image(systemName: "star.slash")
                }
                .tint(.green)
            default:
                EmptyView()
            }
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                DataController().deleteTask(task: task, context: context)
            } label: {
                Image(systemName: "trash.fill")
            }
            
            if !task.isDone {
                Button(role: .none) {
                    selectedTask = task
                } label: {
                    Image(systemName: "square.and.pencil")
                }
                .tint(.blue)
            }
        }
    }
}

extension Date {
    func shortFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
