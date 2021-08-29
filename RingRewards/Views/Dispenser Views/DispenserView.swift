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
                    
                    //DEBUGG ZONE
                    HStack {
                        Button(action: {spinTracker.numPossibleSpins = 3}, label: {
                            Text("Santa")
                                .frame(width: 150, height: 55, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color.red)
                                .font(.system(size: 20, weight: .bold))
                                .cornerRadius(10)
                                .padding()
                        })
                        Button(action: {spinTracker.numPossibleSpins = 0
                            spinTracker.numUserSpins = 0
                        }, label: {
                            Text("Grinch")
                                .frame(width: 150, height: 55, alignment: .center)
                                .foregroundColor(Color.white)
                                .background(Color.green)
                                .font(.system(size: 20, weight: .bold))
                                .cornerRadius(10)
                                .padding()
                            
                        })
                    }
                    //END DEGBBUG ZONE
                }
            }
        }
    }
}


struct DispenserView_Previews: PreviewProvider {
    static var previews: some View {
        DispenserView()
    }
}
