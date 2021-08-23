//
//  HealthStore.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import Foundation
import HealthKit
import SwiftUI
import HealthKitUI

class HealthStore {
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
        let activitySummary = HKObjectType.activitySummaryType()
        
        guard let healthStore = self.healthStore else { return completion(false) }
        
        healthStore.requestAuthorization(toShare: [], read: [activeEnergy, activitySummary]) { (success, error) in
            completion(success)
        }
    }
    
    func getActivitySummary(completion: @escaping (HKActivitySummary) -> ()) {
        let calendar = Calendar.autoupdatingCurrent
        var dateComponents = calendar.dateComponents([.year, .month, .day],from: Date())
        dateComponents.calendar = calendar
        
        let predicate = HKQuery.predicateForActivitySummary(with: dateComponents)
        
        let query = HKActivitySummaryQuery(predicate: predicate) {
            query, summaries, error in
            if let recentSummary = summaries?.first {
                DispatchQueue.main.async {
                    completion(recentSummary);
                }
                print("summary sent")
            } else {
                //VALUES FOR TESTING
                let recentSummary = HKActivitySummary()
                recentSummary.activeEnergyBurned = HKQuantity(unit: HKUnit.largeCalorie(), doubleValue: 450)
                recentSummary.activeEnergyBurnedGoal = HKQuantity(unit: HKUnit.largeCalorie(), doubleValue: 600)
                recentSummary.appleExerciseTime = HKQuantity(unit: HKUnit.minute(), doubleValue: 35)
                recentSummary.appleExerciseTimeGoal = HKQuantity(unit: HKUnit.minute(), doubleValue: 60)
                recentSummary.appleStandHours = HKQuantity(unit: HKUnit.count(), doubleValue: 8)
                recentSummary.appleStandHoursGoal = HKQuantity(unit: HKUnit.count(), doubleValue: 12)
                DispatchQueue.main.async {
                    completion(recentSummary)
                }
                print("testing values summary sent")
            }
        }
        healthStore?.execute(query)
    }
}
