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
            UserDefaults.standard.set(numPossibleSpins, forKey: "numPossibleSpins")
        }
    }
    
    var dailyResetTime: Date {
        didSet {
            UserDefaults.standard.set(dailyResetTime, forKey: "dailyResetTime")
        }
    }
    
    var didPlayChance: Bool {
        didSet {
            UserDefaults.standard.set(didPlayChance, forKey: "didPlayChance")
        }
    }
    
    init() {
        UserDefaults.standard.register(defaults: [
            "numUserSpins" : 0,
            "numPossibleSpins" : 3,
            "dailyResetTime" : Calendar.current.startOfDay(for: Date() - 1),
            "didPlayChance" : false
        ])
        numUserSpins = UserDefaults.standard.integer(forKey: "numUserSpins")
        numPossibleSpins = UserDefaults.standard.integer(forKey: "numPossibleSpins")
        dailyResetTime = UserDefaults.standard.object(forKey: "dailyResetTime") as! Date
        didPlayChance = UserDefaults.standard.bool(forKey: "didPlayChance")
    }
}
