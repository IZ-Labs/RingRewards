//
//  SettingsButton.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct SettingsButton: View {
    var settings: RingViewModel
    var title: String
    @State var realTimeGoal: String = UserDefaults.standard.string(forKey: "Tracking Goal") ?? "Move"
    
    var body: some View {
        Button(action: {
            realTimeGoal = title
            settings.goalChange(goal: title)
        }, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10).frame(width: 100, height: 55, alignment: .center).foregroundColor(settings.getSettingsColor(title: title))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke((realTimeGoal==title ? Color.white : Color.black), lineWidth: 2))
                    //MARK: - The above code results in two of the buttons being "selected" at once. Still needs to be fixed
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
        SettingsButton(settings: RingViewModel(), title: "Exercise")
    }
}
