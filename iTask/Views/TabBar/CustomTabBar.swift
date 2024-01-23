//
//  CustomTabBar.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-23.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            HStack(spacing: 45) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    /// Icons in tab bar.
                    Image(systemName: tab.icon)
                        .imageScale(.large)
                        .foregroundColor(selectedTab == tab ? .blue : .secondary.opacity(0.5))
                        .font(.system(size: 18))
                        .scaleEffect(selectedTab == tab ? 1.2 : 1)
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.15)){
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 80)
            .background(.thinMaterial)
            .cornerRadius(20)
            .padding()
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.tasks))
    }
}
