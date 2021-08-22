//
//  SummaryView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct SummaryView: View {
    @StateObject private var ringProgress: RingViewModel = RingViewModel()
    
    var body: some View {
        CardView(height: 280, content: {
            Text("Today's Progress").font(.largeTitle).fontWeight(.bold)
            RingView(activitySummaryWrapper: ringProgress).frame(width: 125, height: 125, alignment: .center).padding(.all, 10)
            HStack(alignment: .firstTextBaseline, spacing: 0.1, content: {
                Text("Currently: ")
                    .font(.title3)
                    .fontWeight(.semibold)
                Text("\(String(format: "%.1f", ringProgress.getPercent())) %")
                    .foregroundColor(ringProgress.getColor())
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
