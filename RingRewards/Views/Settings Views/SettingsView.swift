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
                HStack{
                    Spacer()
                    Text("Settings")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width*0.90, height: 80, alignment: .leading)
                    Spacer()
                }
                GoalChoiceView()
                RangeChoiceView()
                IPChoiceView()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(SettingsViewModel())
    }
}
