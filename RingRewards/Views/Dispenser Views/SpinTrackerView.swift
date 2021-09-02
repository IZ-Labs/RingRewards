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
    
    var body: some View {
        CardView(height: 80, content: {
            HStack {
                Text("# of Avaliable Rewards: ")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("\(spinTracker.numUserSpins)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.orange)
            }
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
