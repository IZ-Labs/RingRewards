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
    @State var lowEnd: Double = 0
    @State var highEnd: Double = 100
    @State private var HKAuth: Bool = false
    
    private var healthStore: HealthStore? = HealthStore()
    private var progress: Double = 0
    private var numSpins: Int = 0
    
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
        progress = getPercent()*0.01
        numSpins = spinCalc(lowGoal: lowEnd, highGoal: highEnd)
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
    
    func spinCalc(lowGoal: Double, highGoal: Double) -> Int {
        let levels = (highGoal - lowGoal) / 3;
        let percent = getPercent();
        var sumSpins = 0;
        
        if percent > lowGoal {
            if percent > highGoal {
                sumSpins += 3
            }
            else if percent > lowGoal + 2*levels {
                sumSpins += 2
            }
            else if percent > lowGoal {
                sumSpins += 1
            }
        }
        return sumSpins
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


