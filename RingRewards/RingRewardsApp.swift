//
//  RingRewardsApp.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

@main
struct RingRewardsApp: App {
    @StateObject var settings = SettingsViewModel()
    @StateObject var spinTracker = SpinViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .onAppear(perform: { spinTracker.refreshTasks(settings: settings) })
                .environmentObject(settings)
                .environmentObject(spinTracker)
        }
    }
}
