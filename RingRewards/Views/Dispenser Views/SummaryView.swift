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
    @Environment(\.sizeCategory) var sizeCategory
    @ScaledMetric var scaleSize: CGFloat = 1
    
    var body: some View {
        CardView(height: 280, content: {
            VStack {
                Text("Today's Progress")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                RingView()
                    .frame(width: scaleSize*125, height: scaleSize*125, alignment: .center)
                    .padding(.all, 10)
                if sizeCategory <= ContentSizeCategory.accessibilityExtraLarge {
                    HStack(alignment: .firstTextBaseline, spacing: 0.1, content: {
                        Text("Currently: ")
                            .font(.title3)
                            .fontWeight(.semibold)
                        if settings.getPercent().isNaN {
                            Text("N/A. Approve health access")
                                .foregroundColor(settings.goalColor)
                                .font(.body)
                                .fontWeight(.semibold)
                                .onAppear(perform: {settings.requestHKAuth()})
                        } else {
                            Text("\(String(format: "%.1f", settings.getPercent())) %")
                                .foregroundColor(settings.goalColor)
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                    })
                } else {
                    VStack(spacing: 0.1, content: {
                        Text("Currently: ")
                            .font(.title3)
                            .fontWeight(.semibold)
                        if settings.getPercent().isNaN {
                            Text("N/A. Approve Health Access")
                                .foregroundColor(settings.goalColor)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .onAppear(perform: {settings.requestHKAuth()})
                        } else {
                            Text("\(String(format: "%.1f", settings.getPercent())) %")
                                .foregroundColor(settings.goalColor)
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                    })
                }
            }.padding(25)
        })
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView().environmentObject(SettingsViewModel())
    }
}
