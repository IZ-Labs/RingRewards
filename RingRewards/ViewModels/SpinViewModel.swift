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
    
    func isResetRequired() -> Bool {
        if let diff = Calendar.current.dateComponents([.hour], from: dailyResetTime, to: Date()).hour, diff > 24 {
            resetDailySpins()
            return true
        } else {
            return false
        }
    }
    
    func resetDailySpins() {
        dailyResetTime = Calendar.current.startOfDay(for: Date())
        numPossibleSpins = 3
        numUserSpins = 0
    }
    
    func spin(spins: Int, settings: SettingsViewModel){
        if numUserSpins > 0 {
            numUserSpins -= spins
            let url = URL(string: "http:\(settings.ipVal)/setSpins?count=\(spins)")!
            let session = URLSession.shared
            let request = URLRequest(url: url)
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                                            guard error == nil else {
                                                print("network error")
                                                return
                                            }})
            task.resume()
        }
        spinCalc(settings: settings)
    }
    
    func spinCalc(settings: SettingsViewModel) {
        let levels = (settings.highBar - settings.lowBar) / 3;
        let percent = settings.getPercent()
        let lowGoal = settings.lowBar
        let highGoal = settings.highBar
        var earnedSpins = 0;
        
        if percent > lowGoal {
            if percent > highGoal {
                earnedSpins += (numPossibleSpins == 0) ? 0 : numPossibleSpins
            }
            else if percent > lowGoal + 2*levels {
                earnedSpins += (numPossibleSpins == 0) ? 0 : (numPossibleSpins - 1)
            }
            else if percent > lowGoal {
                earnedSpins += (numPossibleSpins == 0) ? 0 : (numPossibleSpins - 2)
            }
        } else {
            earnedSpins = 0
        }
        numUserSpins += earnedSpins
        numPossibleSpins -= earnedSpins
    }
}
