//
//  SummaryView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI
import HealthKit

struct SummaryView: View {
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        CardView(height: 280, content: {
            Text("Today's Progress")
                .font(.largeTitle)
                .fontWeight(.bold)
            RingView()
                .frame(width: 125, height: 125, alignment: .center)
                .padding(.all, 10)
            HStack(alignment: .firstTextBaseline, spacing: 0.1, content: {
                Text("Currently: ")
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("\(String(format: "%.1f", settings.getPercent())) %")
                    .foregroundColor(settings.goalColor)
                    .font(.title3)
                    .fontWeight(.semibold)
            })
        })
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
