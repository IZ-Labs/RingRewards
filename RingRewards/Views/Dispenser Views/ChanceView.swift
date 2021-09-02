//
//  DispenserView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/29/21.
//

import SwiftUI

struct ChanceView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var spinTracker: SpinViewModel
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("darkBlue"), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    Text("Chance").font(.system(size: 38, weight: .bold, design: .default)).foregroundColor(.white).frame(width: UIScreen.main.bounds.width*0.90, height: 80, alignment: .leading)
                    ChanceTextView()
                }
            }
        }
    }
}


struct ChanceView_Previews: PreviewProvider {
    static var previews: some View {
        ChanceView()
            .environmentObject(SettingsViewModel())
            .environmentObject(SpinViewModel())
    }
}
