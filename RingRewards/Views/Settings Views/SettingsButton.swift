//
//  SettingsButton.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct SettingsButton: View {
    @EnvironmentObject var settings: SettingsViewModel
    var title: String
    @Binding var RTGoal: String
    
    var body: some View {
        Button(action: {
            RTGoal = title
            settings.trackingGoal = title
        }, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 100, height: 55, alignment: .center)
                    .foregroundColor(settings.getSettingsColor(title: title))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(goalTrack(goal: title), lineWidth: 2))
                    .padding(.all, 3)
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        })
    }
    
    func goalTrack(goal: String) -> Color {
        if RTGoal == goal{
            return Color.white
        }
        else{
            return Color.black
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    @State static var testString = "Exercise"
    @ObservedObject static var testSettings = SettingsViewModel()
    
    static var previews: some View {
        SettingsButton(title: "Exercise", RTGoal: $testString)
    }
}
