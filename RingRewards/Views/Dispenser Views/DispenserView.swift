//
//  DispenserView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/29/21.
//

import SwiftUI

struct DispenserView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var spinTracker: SpinViewModel
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("darkBlue"), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false){
                PullToRefresh(coordinateSpaceName: "pullToRefresh", onRefresh: {
                    settings.updateRings()
                    spinTracker.spinCalc(settings: settings)
                    print("Daily total reset: \(spinTracker.isResetRequired())")
                })
                VStack{
                    SummaryView()
                        .onAppear(perform: { settings.updateRings() })
                    SpinTrackerView()
                        .onAppear(perform: { spinTracker.spinCalc(settings: settings) })
                    CandyControlView()
                        .onAppear(perform: {
                            print("Daily total reset: \(spinTracker.isResetRequired())")
                        })
                }
            }
        }
    }
}


struct DispenserView_Previews: PreviewProvider {
    static var previews: some View {
        DispenserView()
            .environmentObject(SettingsViewModel())
            .environmentObject(SpinViewModel())
    }
}
