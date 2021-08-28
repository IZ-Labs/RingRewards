//
//  SummaryView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct GoalChoiceView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @State var realTimeGoal = UserDefaults.standard.string(forKey: "trackingGoal") ?? "Move"
    
    var body: some View {
        CardView(height: 150, content: {
            Text("What goal do you want to track?")
                .font(.title3)
                .fontWeight(.bold)
            HStack(alignment: .center, spacing: 0.1, content: {
                SettingsButton(title: "Move", RTGoal: $realTimeGoal)
                SettingsButton(title: "Exercise", RTGoal: $realTimeGoal)
                SettingsButton(title: "Stand", RTGoal: $realTimeGoal)
            })
        })
    }
}

struct GoalChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        GoalChoiceView()
    }
}
