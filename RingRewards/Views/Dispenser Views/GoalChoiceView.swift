//
//  SummaryView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct GoalChoiceView: View {
    var settings: SettingsViewModel
    
    var body: some View {
        CardView(height: 150, content: {
            Text("What goal do you want to track?").font(.title2).fontWeight(.bold)
            HStack(alignment: .center, spacing: 0.1, content: {
                SettingsButton(settings: settings, title: "Move")
                SettingsButton(settings: settings, title: "Exercise")
                SettingsButton(settings: settings, title: "Stand")
            })
        })
    }
}

struct GoalChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        GoalChoiceView(settings: SettingsViewModel())
    }
}
