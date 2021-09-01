//
//  SummaryView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI
import HealthKit

struct ChanceTextView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @State var maxValue = 100
    private var generator = SystemRandomNumberGenerator()
    private var randNum = (1...100).randomElement()
    @State private var textIn = "0"
    @State private var guess = 0.0
    
    var body: some View {
        CardView(height: 210, content: {
            Text("Enter a number between\n1 and \(maxValue) for a chance at an\nextra reward")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            TextField("Input Whole Number", text: $textIn, onCommit:{
                guess = Double(textIn)!
            })
            .font(.system(size: 20, weight: .bold, design: .default))
            .frame(width: 300, height: 50, alignment: .center)
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.vertical)
            .multilineTextAlignment(.center)
        })
    }
}

struct ChanceTextView_Previews: PreviewProvider {
    static var previews: some View {
        ChanceTextView().environmentObject(SettingsViewModel())
    }
}
