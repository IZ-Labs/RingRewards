//
//  SettingsModel.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import Foundation
import SwiftUI

class SettingsModel {
    @AppStorage("trackingGoal") var trackingGoal: String = "Move" {
        didSet {
            UserDefaults.standard.set(trackingGoal, forKey: "trackingGoal")
            print("set \(trackingGoal) as trackingGoal")
        }
    }
    
    @AppStorage("lowBar") var lowBar: Double = 0 {
        didSet {
            UserDefaults.standard.set(lowBar, forKey: "lowBar")
        }
    }
    
    @AppStorage("highBar") var highBar: Double = 100 {
        didSet {
            UserDefaults.standard.set(highBar, forKey: "highBar")
        }
    }
    
    @AppStorage("ipVal") var ipVal: String = "192.168.0.108" {
        didSet {
            UserDefaults.standard.set(ipVal, forKey: "ipVal")
        }
    }
    
    @AppStorage("HKAuth") var HKAuth: Bool = false {
        didSet {
            UserDefaults.standard.set(HKAuth, forKey: "HKAuth")
        }
    }
    
    @AppStorage("wifiAuth") var wifiAuth: Bool = false {
        didSet {
            UserDefaults.standard.set(wifiAuth, forKey: "wifiAuth")
        }
    }
    
    @AppStorage("hasOnboarded") var hasOnboarded: Bool = false {
        didSet {
            UserDefaults.standard.set(hasOnboarded, forKey: "hasOnboarded")
        }
    }
    
    init() {
        UserDefaults.standard.register(defaults: [
            "trackingGoal" : "Move",
            "lowBar" : 50,
            "highBar" : 100,
            "ipVal" : "192.168.0.108",
            "HKAuth" : false,
            "wifiAuth" : false,
            "hasOnboarded" : false
        ])
        trackingGoal = UserDefaults.standard.string(forKey: "trackingGoal")!
        lowBar = UserDefaults.standard.double(forKey: "lowBar")
        highBar = UserDefaults.standard.double(forKey: "highBar")
        ipVal = UserDefaults.standard.string(forKey: "ipVal")!
        HKAuth = UserDefaults.standard.bool(forKey: "HKAuth")
        wifiAuth = UserDefaults.standard.bool(forKey: "wifiAuth")
        hasOnboarded = UserDefaults.standard.bool(forKey: "hasOnboarded")
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
