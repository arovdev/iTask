// ContentView.swift

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var taskData: TaskData
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var tasks: FetchedResults<Task>
    
    @State private var showingAddTask: Bool = false
    @State private var selectedTask: Task?
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Favorites")) {
                        ForEach(filteredTasks.filter { $0.isFavorite }) { task in
                            TaskRow(task: task, selectedTask: $selectedTask)
                        }
                    }

                    Section(header: Text("Tasks")) {
                        ForEach(filteredTasks.filter { !$0.isDone && !$0.isFavorite }) { task in
                            TaskRow(task: task, selectedTask: $selectedTask)
                        }
                    }
                    
                    Section(header: Text("Done")) {
                        ForEach(filteredTasks.filter { $0.isDone }) { task in
                            TaskRow(task: task, selectedTask: $selectedTask)
                        }
                    }
                }
                .searchable(text: $taskData.searchText, prompt: "Search")
            }
            .navigationTitle("iTask")
            .toolbar {
                /// Debug Mode
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        taskData.debug.toggle()
//                    } label: {
//                        Image(systemName: "exclamationmark.triangle")
//                    }
//                    .tint(taskData.debug ? .red : .gray)
//                }
                
                /// Add Task
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddTask.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                /// Change Theme
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        taskData.darkMode.toggle()
                    } label: {
                        Image(systemName: taskData.darkMode ? "moon.fill" : "sun.max.fill")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                VStack {
                    AddTaskView()
                }
                .presentationDetents([.fraction(0.8)])
                .presentationDragIndicator(.visible)
            }
            .sheet(item: $selectedTask) { task in
                VStack {
                    EditTaskView(task: task)
                }
                .presentationDetents([.fraction(0.5)])
                .presentationDragIndicator(.visible)
            }
            .preferredColorScheme(taskData.darkMode ? .dark : .light)
        }
    }
    
    var filteredTasks: [Task] {
        let allTasks = Array(tasks)
        
        if taskData.searchText.isEmpty {
            return allTasks
        } else {
            return allTasks.filter {
                $0.title?.localizedCaseInsensitiveContains(taskData.searchText) == true
            }
        }
    }
}
