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
                withAnimation(.easeIn(duration: 0.1)) {
                    appData.showingAddTask.toggle()
                }
            } label: {
                Image(systemName: "plus")
                    .bold()
                    .imageScale(.large)
                    .foregroundColor(.white)
            }
            .padding(20)
            .background(appData.selectedTab == .tasks ? .blue : .gray)
            .clipShape(Circle())
            .rotationEffect(Angle(degrees: appData.selectedTab == .tasks ? 0 : 45))
            .disabled(appData.selectedTab == .tasks ? false : true)
        }
    }
}
