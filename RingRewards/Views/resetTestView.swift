//
//  resetTestView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/30/21.
//

import SwiftUI

struct resetTestView: View {
    @EnvironmentObject var spinTracker: SpinViewModel
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        VStack{
            Text("Debugging Controls")
                .font(.largeTitle)
                
            Spacer()
            Text("Spins control")
                .font(.title3)
            Text("Possible Spins: \(spinTracker.numPossibleSpins)")
                .font(.title)
            HStack {
                Button(action: {spinTracker.numPossibleSpins = 3}, label: {
                    Text("Give")
                        .frame(width: 150, height: 55, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.green)
                        .font(.system(size: 20, weight: .bold))
                        .cornerRadius(10)
                        .padding()
                })
                Button(action: {spinTracker.numPossibleSpins = 0
                    spinTracker.numUserSpins = 0
                }, label: {
                    Text("Take")
                        .frame(width: 150, height: 55, alignment: .center)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .font(.system(size: 20, weight: .bold))
                        .cornerRadius(10)
                        .padding()
                    
                })
            }
            Spacer()
            Text("The number of avaliable spins was last reset\n \(spinTracker.dailyResetTime).")
            Spacer()
            Text("The current diff value is \(calcDiff())")
            Spacer()
        }
        .onAppear(perform: { spinTracker.spinCalc(settings: settings) })
    }
    func calcDiff() -> Int {
        print("debug diff calculated")
        return Calendar.current.dateComponents([.hour], from: spinTracker.dailyResetTime, to: Date()).hour ?? 80085
    }
}

struct resetTestView_Previews: PreviewProvider {
    static var previews: some View {
        resetTestView()
            .environmentObject(SpinViewModel())
            .environmentObject(SettingsViewModel())
    }
}
