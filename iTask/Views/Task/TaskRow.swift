//
//  TaskRow.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-20.
//

import SwiftUI

struct TaskRow: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var taskData: TaskData
    
    var task: Task
    @Binding var selectedTask: Task?

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.title ?? "No Title")
                    Text("\(task.date?.shortFormatted() ?? "No date")")
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                /// Task icon.
                HStack(spacing: 12) {
                    Image(systemName: taskIconName)
                        .imageScale(.large)
                        .foregroundColor(taskIconColor)
                        .onTapGesture {
                            handleTaskIconTap()
                        }
                }
            }
            
            if taskData.debug {
                VStack(alignment: .leading){
                    Text(task.debug)
                }
                .foregroundColor(.gray)
            }
        }
        .swipeActions(edge: .leading) {
            leadingSwipeActions
        }
        .swipeActions(edge: .trailing) {
            trailingSwipeActions
        }
    }
    
    // MARK: - Computed Properties
    
    private var taskIconName: String {
        task.isDone ? "circle.inset.filled" : (task.isImportant ? "calendar.badge.exclamationmark" : "circle")
    }
    
    private var taskIconColor: Color {
        task.isDone ? .blue : (task.isImportant ? .red : .blue)
    }
    
    // MARK: - Action Handling
    
    private func handleTaskIconTap() {
        if task.isDone || !task.isDone && !task.isImportant {
            DataController().doneTask(task: task, context: context)
        }
    }

    // MARK: - Swipe Actions
    
    private var leadingSwipeActions: some View {
        switch (task.isDone, task.isImportant) {
        case (false, false):
            return AnyView(
                Group {
                    Button {
                        DataController().doneTask(task: task, context: context)
                    } label: {
                        Image(systemName: "circle.dashed.inset.filled")
                    }
                    .tint(.blue)
                    
                    Button {
                        DataController().importantTask(task: task, context: context)
                    } label: {
                        Image(systemName: "calendar.badge.exclamationmark")
                    }
                    .tint(.red)
                })
        case (true, false):
            return AnyView(
                Group {
                    Button {
                        DataController().doneTask(task: task, context: context)
                    } label: {
                        Image(systemName: "circle.dashed")
                    }
                    .tint(.blue)
                })
        case (false, true):
            return AnyView(
                Group {
                    Button {
                        DataController().importantTask(task: task, context: context)
                    } label: {
                        Image(systemName: "calendar")
                    }
                    .tint(.green)
                    
                    Button {
                        DataController().doneTask(task: task, context: context)
                    } label: {
                        Image(systemName: "circle.dashed.inset.filled")
                    }
                    .tint(.blue)
                })
        default:
            return AnyView(EmptyView())
        }
    }
    
    private var trailingSwipeActions: some View {
        return HStack {
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

// MARK: - Extensions

extension Task {
    var debug: String {
        """
        {
            "id": "\(id?.uuidString ?? "No ID")",
            "title": "\(title ?? "No Title")",
            "isDone": \(isDone ? "true" : "false"),
            "isImportant": \(isImportant ? "true" : "false"),
        }
        """
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
