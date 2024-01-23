//
//  Tab.swift
//  iTask
//
//  Created by Arthur Reshetnyak on 2024-01-23.
//

import Foundation
import SwiftUI

enum Tab: String, CaseIterable {
    case tasks
    case settings

    var icon: String {
        switch self {
        case .tasks:
            return "list.triangle"
        case .settings:
            return "gearshape.fill"
        }
    }
}
