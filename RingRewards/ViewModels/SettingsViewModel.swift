//
//  SettingsViewModel.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/28/21.
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
        set { settings.trackingGoal = newValue
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    var lowBar: Double {
        get { Double(settings.lowBar) }
        set { settings.lowBar = Double(newValue)
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    var highBar: Double {
        get { Double(settings.highBar) }
        set { settings.highBar = Double(newValue)
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    var ipVal: String {
        get { settings.ipVal }
        set { settings.ipVal = newValue
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    var HKAuth: Bool {
        get { settings.HKAuth }
        set { settings.HKAuth = newValue
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    var wifiAuth: Bool {
        get { settings.wifiAuth }
        set { settings.wifiAuth = newValue
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    var settingsInitalized: Bool {
        get { settings.settingsInitalized }
        set { settings.settingsInitalized = newValue
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    var hasOnboarded: Bool {
        get { settings.hasOnboarded }
        set { settings.hasOnboarded = newValue
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    
    var goalColor: Color {
        get { return settings.goalColor }
    }
    
    func requestHKAuth() {
        if let healthStore = healthStore {
            healthStore.requestAuthorization { success in
                if success {
                    print("HK authorization success")
                    self.HKAuth = true
                    healthStore.getActivitySummary(completion: {recentSummary in self.summary = recentSummary })
                }
            }
        }
    }
    
    func requestWifiAuth() {
        let url = URL(string: "https://www.apple.com")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if response != nil {
                self.wifiAuth = true
                print("Wifi Authorized")
            }
        })
        task.resume()
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
                requestHKAuth()
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
