//
//  SettingsView.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        NavigationView {
            List {
                // MARK: - Appearance Section
                AppearanceSection()
            }
            .navigationTitle("Settings")
        }
    }
}

// MARK: - Extensions

extension SettingsView {
    func AppearanceSection() -> some View {
        Section(header: Text("Appearance")) {
            Toggle("Dark Mode", isOn: $appData.darkMode)
        }
    }
}
