//
//  SettingsView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("darkBlue"), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    Text("Settings").font(.system(size: 38, weight: .bold, design: .default)).foregroundColor(.white).frame(width: UIScreen.main.bounds.width*0.90, height: 100, alignment: .leading)
                    GoalChoiceView()
                    RangeChoiceView()
                    IPChoiceView()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
