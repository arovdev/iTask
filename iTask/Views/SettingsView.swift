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
                
                // MARK: - About Section
                AboutSection()
                
                // MARK: - App Section
                AppSection()
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
    
    func AboutSection() -> some View {
        Section(header: Text("About")) {
            /// Contacts.
            Text("Developer : Artur Reshetniak")
            Text("Email : artur.reshetniak@gmail.com")
        }
    }
    
    func AppSection() -> some View {
        Section(header: Text("App")) {
            /// App version.
            if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                Text("Version : \(appVersion)")
            } else {
                Text("Version : Information not available")
            }
        }
    }
}
