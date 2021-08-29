//
//  SettingsViewModel.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/27/21.
//

import Foundation
import SwiftUI
import HealthKitUI

class SettingsViewModel: ObservableObject {
    @Published var settings = SettingsModel()
    @Published var summary = HKActivitySummary()

    private var healthStore: HealthStore? = HealthStore()
    
    var trackingGoal: String {
        get { settings.trackingGoal }
        set { settings.trackingGoal = newValue }
    }
    
    var numSpins: Int {
        get { settings.numSpins }
        set { settings.numSpins = newValue }
    }
    
    var lowBar: Double {
        get { Double(settings.lowBar) }
        set { settings.lowBar = Double(newValue) }
    }
    
    var highBar: Double {
        get { Double(settings.highBar) }
        set { settings.highBar = Double(newValue) }
    }
    
    var ipVal: String {
        get { settings.ipVal }
        set { settings.ipVal = newValue }
    }
    
    var HKAuth: Bool {
        get { settings.HKAuth }
        set { settings.HKAuth = newValue }
    }
    
    var goalColor: Color {
        get { return settings.goalColor }
    }
    
    func HKAuthorized() {
        settings.HKAuth.toggle()
    }
    
    func getSettingsColor (title: String) -> Color {
        switch title {
        case "Move": return .red
        case "Exercise": return .green
        case "Stand": return .blue
        default: return .pink
        }
    }
    
    func updateRings() -> Void {
        if let healthStore = healthStore {
            if HKAuth {
                healthStore.getActivitySummary(completion: {recentSummary in self.summary = recentSummary })
            } else {
                healthStore.requestAuthorization { success in
                    if success {
                        print("HK authorization success")
                        healthStore.getActivitySummary(completion: {recentSummary in self.summary = recentSummary })
                    }
                }
                HKAuth.toggle()
            }
        }
    }
    
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
}
