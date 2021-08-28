//
//  SettingsModel.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import Foundation
import SwiftUI

class SettingsModel {
    var trackingGoal: String {
            didSet {
                UserDefaults.standard.set(trackingGoal, forKey: "trackingGoal")
                print("\(trackingGoal) set as new goal in SettingsModel")
            }
        }
    
    var lowBar: Double {
            didSet {
                UserDefaults.standard.set(lowBar, forKey: "lowBar")
            }
        }
    
    var highBar: Double {
            didSet {
                UserDefaults.standard.set(highBar, forKey: "highBar")
            }
        }
    
    var ipVal: String {
            didSet {
                UserDefaults.standard.set(ipVal, forKey: "ipVal")
            }
        }
    
    var HKAuth: Bool {
            didSet {
                UserDefaults.standard.set(HKAuth, forKey: "HKAuth")
            }
        }
    
    init() {
        UserDefaults.standard.register(defaults: [
            "trackingGoal" : "Move",
            "lowBar" : 0,
            "highBar" : 100,
            "ipVal" : "198.168.0.108",
            "HKAuth" : false
        ])
        trackingGoal = UserDefaults.standard.string(forKey: "trackingGoal")!
        lowBar = UserDefaults.standard.double(forKey: "lowBar")
        highBar = UserDefaults.standard.double(forKey: "highBar")
        ipVal = UserDefaults.standard.string(forKey: "ipVal")!
        HKAuth = UserDefaults.standard.bool(forKey: "HKAuth")
    }
    
    public var goalColor: Color {
        switch trackingGoal{
        case "Move": return .red
        case "Exercise": return .green
        case "Stand": return .blue
        default: return .white
        }
    }
}
