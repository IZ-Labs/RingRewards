//
//  ChanceView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 9/01/21.
//

import SwiftUI

struct ChanceView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var spinTracker: SpinViewModel
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("darkBlue"), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false){
                HStack {
                    Spacer()
                    Text("Chance")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width*0.9, height: 80, alignment: .leading)
                    Spacer()
                }
                ChanceTextView()
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
