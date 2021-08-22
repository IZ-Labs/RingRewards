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
    
    init(healthStore: HKHealthStore) {
        if HKHealthStore.isHealthDataAvailable() {
            self.healthStore = HKHealthStore()
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let activeEnergy = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
        let activitySummary = HKObjectType.activitySummaryType()
        
        guard let healthStore = self.healthStore else {
            return completion(false)
        }
        
        healthStore.requestAuthorization(toShare: [], read: [activeEnergy, activitySummary]) {
            (success, error) in completion(success)
        }
    }
    
    
    func getActivitySummary(completion: @escaping (HKActivitySummary) -> ()) {
        let calendar = Calendar.autoupdatingCurrent
        var dateComponents = calendar.dateComponents([.year, .month, .day],from: Date())
        dateComponents.calendar = calendar
        
        let predicate = HKQuery.predicateForActivitySummary(with: dateComponents)
        
        let query = HKActivitySummaryQuery(predicate: predicate) {
            query, summaries, error in
            if let summary = summaries?.first {
                DispatchQueue.main.async {
                    completion(summary);
                    print("summary sent")
                }
            } else {
                //VALUES FOR TESTING
                let summary = HKActivitySummary()
                summary.activeEnergyBurned = HKQuantity(unit: HKUnit.largeCalorie(), doubleValue: 450)
                summary.activeEnergyBurnedGoal = HKQuantity(unit: HKUnit.largeCalorie(), doubleValue: 600)
                summary.appleExerciseTime = HKQuantity(unit: HKUnit.minute(), doubleValue: 35)
                summary.appleExerciseTimeGoal = HKQuantity(unit: HKUnit.minute(), doubleValue: 60)
                summary.appleStandHours = HKQuantity(unit: HKUnit.count(), doubleValue: 8)
                summary.appleStandHoursGoal = HKQuantity(unit: HKUnit.count(), doubleValue: 12)
                DispatchQueue.main.async {
                    completion(summary)
                }
            }
        }
        healthStore?.execute(query)
    }
}
