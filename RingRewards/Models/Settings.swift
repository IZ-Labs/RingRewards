//
//  SettingsModel.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import Foundation

struct Settings {
    private(set) var trackingGoal: String = UserDefaults.standard.string(forKey: "Tracking Goal") ?? "Move"
    private(set) var lowBar: Double = UserDefaults.standard.double(forKey: "Low Goal")
    private(set) var highBar: Double = UserDefaults.standard.double(forKey: "High Goal")
    private(set) var ipVal: String = UserDefaults.standard.string(forKey: "IP Address") ?? "198.168.0.108"
    
    private(set) var HKAuth: Bool = false
    
//    init(goal: trackingGoal, low: lowBar, high: highBar, ip: ipVal){
//        updateTrackingGoal(changeTo: trackingGoal)
//        updateLowBar(changeTo: lowBar)
//        updateHighBar(changeTo: highBar)
//        updateIP(changeTo: ipVal)
//    }
    
    mutating func updateTrackingGoal(changeTo newGoal: String) {
        UserDefaults.standard.set(newGoal, forKey: "Tracking Goal")
    }
    
    mutating func updateLowBar(changeTo newGoal: Double) {
        UserDefaults.standard.set(newGoal, forKey: "Low Goal")
    }
    
    mutating func updateHighBar(changeTo newGoal: Double) {
        UserDefaults.standard.set(newGoal, forKey: "High Goal")
    }
    
    mutating func updateIP(changeTo newIP: String) {
        UserDefaults.standard.set(newIP, forKey: "IP Address")
    }
    
    mutating func HKAuthorized() {
        HKAuth.toggle()
    }
}
