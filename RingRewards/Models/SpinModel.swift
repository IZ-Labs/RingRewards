//
//  SpinModel.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/29/21.
//

import Foundation
import SwiftUI

class SpinModel {
    @AppStorage("numUserSpins") var numUserSpins: Int = 0 {
        didSet {
            UserDefaults.standard.set(numUserSpins, forKey: "numUserSpins")
        }
    }
    
    @AppStorage("numPossibleSpins") var numPossibleSpins: Int = 3 {
        didSet {
            UserDefaults.standard.set(numPossibleSpins, forKey: "numPossibleSpins")
        }
    }
    
    @AppStorage("dailyResetTime") var dailyResetTime: Date = Calendar.current.startOfDay(for: Date() - 1) {
        didSet {
            UserDefaults.standard.set(dailyResetTime, forKey: "dailyResetTime")
        }
    }
    
    @AppStorage("didPlayChance") var didPlayChance: Bool = false {
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

extension Date: RawRepresentable {
    public var rawValue: String {
        self.timeIntervalSinceReferenceDate.description
    }
    
    public init?(rawValue: String) {
        self = Date(timeIntervalSinceReferenceDate: Double(rawValue) ?? 0.0)
    }
}
