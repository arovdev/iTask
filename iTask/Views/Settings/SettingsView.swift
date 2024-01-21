//
//  SettingsView.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var taskData: TaskData
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("Settings go here")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
