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
                
                Image(systemName: taskIconName)
                    .imageScale(.large)
                    .foregroundColor(taskIconColor)
                    .onTapGesture {
                        handleTaskIconTap()
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
        task.isDone ? "circle.inset.filled" : (task.isFavorite ? "star.fill" : "circle")
    }
    
    private var taskIconColor: Color {
        task.isDone ? .blue : (task.isFavorite ? .blue : .blue)
    }
    
    // MARK: - Action Handling
    
    private func handleTaskIconTap() {
        if !task.isFavorite {
            DataController().doneTask(task: task, context: context)
        } else {
            DataController().favoriteTask(task: task, context: context)
        }
    }
    
    // MARK: - Swipe Actions
    
    private var leadingSwipeActions: some View {
        switch (task.isDone, task.isFavorite) {
        case (false, false):
            return AnyView(
                Group {
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
                })
        case (true, false):
            return AnyView(
                Group {
                    Button {
                        DataController().doneTask(task: task, context: context)
                    } label: {
                        Image(systemName: "circle.slash")
                    }
                    .tint(.blue)
                })
        case (false, true):
            return AnyView(
                Group {
                    Button {
                        DataController().favoriteTask(task: task, context: context)
                    } label: {
                        Image(systemName: "star.slash")
                    }
                    .tint(.green)
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
            "isFavorite": \(isFavorite ? "true" : "false"),
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
