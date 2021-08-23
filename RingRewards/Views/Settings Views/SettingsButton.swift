//
//  SettingsButton.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct SettingsButton: View {
    var settings: SettingsViewModel
    var title: String
    
    var body: some View {
        Button(action: {
            settings.goalChange(goal: title)
        }, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10).frame(width: 100, height: 55, alignment: .center).foregroundColor(settings.getColor(title: title))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(settings.isSelected(goal: title), lineWidth: 2))
                    .padding(.all, 3)
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold).foregroundColor(.white)
            }
        })
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(settings: SettingsViewModel(), title: "Exercise")
    }
}
