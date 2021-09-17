//
//  SpinViewModel.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/29/21.
//

import Foundation

class SpinViewModel: ObservableObject {
    @Published var spinTracker = SpinModel()
    
    var numUserSpins: Int {
        get { spinTracker.numUserSpins }
        set { spinTracker.numUserSpins = newValue }
    }
    
    var numPossibleSpins: Int {
        get { spinTracker.numPossibleSpins }
        set { spinTracker.numPossibleSpins = newValue }
    }
    
    var dailyResetTime: Date {
        get { spinTracker.dailyResetTime }
        set { spinTracker.dailyResetTime = newValue }
    }
    
    var didPlayChance: Bool {
        get { spinTracker.didPlayChance }
        set { spinTracker.didPlayChance = newValue }
    }
    
    func refreshTasks(settings: SettingsViewModel) {
        print("Daily total reset: \(resetIfRequired())")
        settings.updateRings()
        spinCalc(settings: settings)
    }
    
    func resetIfRequired() -> Bool {
        if let diff = Calendar.current.dateComponents([.hour], from: dailyResetTime, to: Date()).hour, diff >= 24 {
            resetDailyValues()
            return true
        } else {
            return false
        }
    }
    
    func resetDailyValues() {
        dailyResetTime = Calendar.current.startOfDay(for: Date())
        numPossibleSpins = 3
        numUserSpins = 0
        didPlayChance = false
    }
    
    func spin(spins: Int, settings: SettingsViewModel){
        // Currently this is setup to always send 1 spin at a time. If functionality is added to send multiple spins at once
        // the logic for this section should be ammended to avoid negative values.
        if numUserSpins > 0 {
            numUserSpins -= spins
            
            let url = URL(string: "http://\(settings.ipVal)/setSpins?count=\(spins)")!
            let session = URLSession.shared
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                //print(data)
                print(response ?? "ERROR - No Response Recieved")
                //print(error)
            })
            task.resume()
        }
    }
    
    func spinCalc(settings: SettingsViewModel) {
        let levels = (settings.highBar - settings.lowBar) / 3;
        let percent = settings.getPercent()
        let lowGoal = settings.lowBar
        let highGoal = settings.highBar
        var earnedSpins = 0
        
        if percent > lowGoal && numPossibleSpins > 0 {
            if percent > highGoal {
                earnedSpins += numPossibleSpins
            }
            else if percent > lowGoal + 2*levels {
                earnedSpins += numPossibleSpins - 1
            }
            else if percent > lowGoal {
                earnedSpins += numPossibleSpins - 2
            }
        } else {
            earnedSpins = 0
        }
        numUserSpins += earnedSpins
        numPossibleSpins -= earnedSpins
    }
}
