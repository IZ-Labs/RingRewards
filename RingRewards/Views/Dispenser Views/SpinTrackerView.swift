//
//  SpinTrackerView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/28/21.
//

import SwiftUI
import HealthKit

struct SpinTrackerView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var spinTracker: SpinViewModel
    @Environment(\.sizeCategory) var sizeCategory
    @ScaledMetric var scaleSize: CGFloat = 1
    
    var body: some View {
        CardView(height: 80, content: {
            VStack {
                HStack {
                    Text("Available Rewards: ")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("\(spinTracker.numUserSpins)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.orange)
                }
            }.padding(25)
        })
    }
}

struct SpinTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinTrackerView()
            .environmentObject(SettingsViewModel())
            .environmentObject(SpinViewModel())
    }
}
