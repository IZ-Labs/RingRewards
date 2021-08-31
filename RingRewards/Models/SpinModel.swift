//
//  SpinModel.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/29/21.
//

import Foundation

class SpinModel {
    var numUserSpins: Int {
        didSet {
            UserDefaults.standard.set(numUserSpins, forKey: "numUserSpins")
        }
    }
    
    var numPossibleSpins: Int {
        didSet {
            UserDefaults.standard.set(numUserSpins, forKey: "numPossibleSpins")
        }
    }
    
    var dailyResetTime: Date {
        didSet {
            UserDefaults.standard.set(dailyResetTime, forKey: "dailyResetTime")
        }
    }
    
    init() {
        UserDefaults.standard.register(defaults: [
            "numUserSpins" : 0,
            "numPossibleSpins" : 3,
            "dailyResetTime" : Calendar.current.startOfDay(for: Date() - 1)
        ])
        numUserSpins = UserDefaults.standard.integer(forKey: "numUserSpins")
        numPossibleSpins = UserDefaults.standard.integer(forKey: "numPossibleSpins")
        dailyResetTime = UserDefaults.standard.object(forKey: "dailyResetTime") as! Date
    }
}
