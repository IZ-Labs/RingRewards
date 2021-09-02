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
    @EnvironmentObject var spinTracker: SpinViewModel
    
    @State var maxValue = 100
    private var generator = SystemRandomNumberGenerator()
    private var randNum = (1...100).randomElement()
    @State private var textIn = "0"
    @State private var guess = 0.0
    @State private var hasGuessed = false
    @State private var winner = false
    
    var body: some View {
        VStack {
            if !hasGuessed {
                CardView(height: 300, content: {
                    Text("Enter a number between\n1 and \(maxValue) for a chance at an\nextra reward")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text("random value is \(randNum!)")
                    
                    TextField("Input Whole Number", text: $textIn, onCommit:{
                        guess = Double(textIn)!
                    })
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .frame(width: UIScreen.main.bounds.width*0.65, height: 50, alignment: .center)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.vertical)
                    .multilineTextAlignment(.center)
                    
                    if guess != 0 {
                        Button(action: { hasGuessed.toggle() }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.blue)
                                    .frame(width: UIScreen.main.bounds.width*0.4, height: 55, alignment: .center)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 3))
                                Text("Submit Guess")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        })
                    }
                })
            } else {
                CardView(height: 300, content: {
                    VStack{
                        if Int(guess) == randNum {
                            VStack{
                                Image(systemName: "star.circle.fill") .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width*0.3, height: UIScreen.main.bounds.width*0.3, alignment: .center)
                                Text("Winner!\nEnjoy your reward")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                            }.onAppear(perform: {
                                spinTracker.spin(spins: 1, settings: settings)
                            })
                        } else {
                            VStack{
                                Image(systemName: "cloud.heavyrain.fill") .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width*0.3, height: UIScreen.main.bounds.width*0.3, alignment: .center)
                                Text("No Luck!\nTry again tomorrow")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                })
            }
        }
    }
}

struct ChanceTextView_Previews: PreviewProvider {
    static var previews: some View {
        ChanceTextView()
            .environmentObject(SettingsViewModel())
            .environmentObject(SpinViewModel())
    }
}
