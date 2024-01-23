//
//  FAB.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-23.
//

import SwiftUI

struct FAB: View {
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        VStack {
            Button {
                appData.showingAddTask.toggle()
            } label: {
                Image(systemName: "plus")
                    .bold()
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            .padding(20)
            .background(appData.selectedTab == .tasks ? .blue : .gray)
            .clipShape(Circle())
        }
    }
}
