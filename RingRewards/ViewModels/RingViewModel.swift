//
//  RingViewModel.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI
import HealthKitUI

class RingViewModel: ObservableObject {
    @Published var summary: HKActivitySummary = HKActivitySummary()
    @State var trackingGoal: String = "Move"
    
    func getPercent() -> Double {
        switch trackingGoal {
        case "Move":
            let activeEngBurned = round(summary.activeEnergyBurned.doubleValue(for: HKUnit.jouleUnit(with: .kilo)))
            let activeEngGoal = round(summary.activeEnergyBurnedGoal.doubleValue(for: HKUnit.jouleUnit(with: .kilo)))
            let goalPercent = (activeEngBurned/activeEngGoal)*100
            return goalPercent
        case "Exercise":
            let excerciseTime = round(summary.appleExerciseTime.doubleValue(for: HKUnit.minute()))
            let exerciseGoal = round(summary.appleExerciseTimeGoal.doubleValue(for: HKUnit.minute()))
            let goalPercent = (excerciseTime/exerciseGoal)*100
            return goalPercent
        case "Stand":
            let standTime = round(summary.appleStandHours.doubleValue(for: HKUnit.count()))
            let standGoal = round(summary.appleStandHoursGoal.doubleValue(for: HKUnit.count()))
            let goalPercent = (standTime/standGoal)*100
            return goalPercent
        default:
            return 0.0
        }
    }
    
    func getColor () -> Color {
        switch trackingGoal {
        case "Move": return .red
        case "Exercise": return .green
        case "Stand": return .blue
        default: return .white
        }
    }
    
}


