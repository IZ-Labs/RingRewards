//
//  SettingsViewModel.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published private var settings = Settings()
    
    func isSelected(goal: String) -> Color {
        if settings.trackingGoal == goal{
            return Color.white
        } else {
            return Color.black
        }
    }
    
    func goalChange(goal: String) {
        settings.updateTrackingGoal(changeTo: goal)
    }
    
    func getColor (title: String) -> Color {
        switch title {
        case "Move": return .red
        case "Exercise": return .green
        case "Stand": return .blue
        default: return .white
        }
    }
}
