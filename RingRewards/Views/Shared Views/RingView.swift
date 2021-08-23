//
//  RingView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI
import HealthKitUI

struct RingView: UIViewRepresentable {
    @ObservedObject var activitySummaryWrapper: RingViewModel
    
    func makeUIView(context: Context) -> HKActivityRingView {
        let ringView = HKActivityRingView()
        return ringView
    }
    
    func updateUIView(_ uiView: HKActivityRingView, context: Context) {
        uiView.setActivitySummary(activitySummaryWrapper.summary, animated: true)
        print("ringView UI updated")
    }
}
