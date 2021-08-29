//
//  SummaryView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI
import HealthKit

struct SpinTrackerView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var spinTracker: SpinViewModel
    
    var body: some View {
        CardView(height: 80, content: {
            HStack {
                Text("# of Avaliable Spins: ")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("\(spinTracker.numUserSpins)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(settings.goalColor)
                //DEBUGGING
                Text("\(spinTracker.numPossibleSpins)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
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
