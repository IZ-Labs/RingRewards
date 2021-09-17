//
//  GoalChoiceView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct GoalChoiceView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @State var realTimeGoal = UserDefaults.standard.string(forKey: "trackingGoal") ?? "Move"
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        CardView(height: 150, content: {
            VStack {
                Text("What goal do you want to track?")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(5.0)
                if sizeCategory > ContentSizeCategory.extraExtraLarge {
                    VStack(alignment: .center, spacing: 8, content: {
                        SettingsButton(title: "Move", RTGoal: $realTimeGoal)
                        SettingsButton(title: "Exercise", RTGoal: $realTimeGoal)
                        SettingsButton(title: "Stand", RTGoal: $realTimeGoal)
                    })
                } else {
                    HStack(alignment: .center, spacing: 2, content: {
                        SettingsButton(title: "Move", RTGoal: $realTimeGoal)
                        SettingsButton(title: "Exercise", RTGoal: $realTimeGoal)
                        SettingsButton(title: "Stand", RTGoal: $realTimeGoal)
                    })
                }
            }
            .frame(width: UIScreen.main.bounds.width*0.9, height: nil, alignment: .center)
            .padding(.vertical, 15)
            
        })
    }
}

struct GoalChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        GoalChoiceView()
            .environmentObject(SettingsViewModel())
    }
}
