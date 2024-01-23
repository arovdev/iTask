//
//  TasksView.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-23.
//

import SwiftUI

struct TasksView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var tasks: FetchedResults<Task>
    
    @State private var showingAddTask: Bool = false
    @State private var selectedTask: Task?
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    /// Sections for different task statuses.
                    taskSection(title: "Important", tasks: filteredTasks(for: .important))
                    taskSection(title: "Tasks", tasks: filteredTasks(for: .regular))
                    taskSection(title: "Done", tasks: filteredTasks(for: .done))
                }
            }
            .searchable(text: $appData.searchText, prompt: "Search")
            .navigationTitle("iTask")
            .toolbar {
                toolbars()
            }
            .sheet(isPresented: $showingAddTask) {
                VStack {
                    AddTaskView()
                }
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.visible)
            }
            .sheet(item: $selectedTask) { task in
                VStack {
                    EditTaskView(task: task)
                }
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
            }
            .preferredColorScheme(appData.darkMode ? .dark : .light)
        }
    }
    
    /// Function to build toolbar content.
    @ToolbarContentBuilder
    func toolbars() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                showingAddTask.toggle()
            } label: {
                Image(systemName: "plus")
            }
        }
    }
    
    /// Function to create a section of tasks based on their status.
    func taskSection(title: String, tasks: [Task]) -> some View {
        Section(header: Text(title)) {
            ForEach(tasks) { task in
                TaskRow(task: task, selectedTask: $selectedTask)
            }
        }
    }
    
    /// Function to filter tasks based on their status.
    func filteredTasks(for status: TaskStatus) -> [Task] {
        filteredTasks.filter { task in
            switch status {
            case .important: return task.isImportant
            case .regular: return !task.isDone && !task.isImportant
            case .done: return task.isDone
            }
        }
    }
    
    /// Computed property to get filtered tasks based on search text.
    var filteredTasks: [Task] {
        appData.searchText.isEmpty ? Array(tasks) : Array(tasks.filter { $0.title?.localizedCaseInsensitiveContains(appData.searchText) == true })
    }
}

// MARK: - TaskStatus

enum TaskStatus {
    case important, regular, done
}
