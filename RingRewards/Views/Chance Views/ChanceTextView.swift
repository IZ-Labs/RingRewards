//
//  ChanceTextView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 9/01/21.
//

import SwiftUI
import HealthKit

struct ChanceTextView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var spinTracker: SpinViewModel
    @Environment(\.sizeCategory) var sizeCategory
    @ScaledMetric var scaleSize: CGFloat = 1
    
    @State var maxValue = 20
    private var generator = SystemRandomNumberGenerator()
    private var randNum = (1...20).randomElement()
    @State private var textIn = ""
    @State private var guess = 0.0
    @State private var hasGuessed = false
    @State private var winner = false
    
    var body: some View {
        VStack {
            if !hasGuessed && !spinTracker.didPlayChance{
                CardView(height: 300, content: {
                    VStack {
                        Text("Enter a number between\n1 and \(maxValue) for a chance at an\nextra reward")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                        // Uncomment line below to reveal random num for debugging
                        //Text("random value is \(randNum!)")
                        
                        TextField("Whole Number", text: $textIn)
                            .keyboardType(.numberPad)
                        .font(.title3)
                        .colorScheme(.light)
                        .frame(width: UIScreen.main.bounds.width*0.65, height: scaleSize*50, alignment: .center)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.vertical, 5.0)
                        .multilineTextAlignment(.center)
                        
                        Button(action: {
                            hasGuessed.toggle()
                            spinTracker.didPlayChance = true
                            guess = Double(textIn)!
                            self.textIn = "" // Clear text
                            UIApplication.shared.endEditing() // Call to dismiss keyboard
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.blue)
                                    .frame(width: UIScreen.main.bounds.width*0.4, height: scaleSize*55, alignment: .center)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 3))
                                Text("Submit Guess")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        })
                    }.padding(.vertical, 35)
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
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        } else {
                            VStack{
                                Image(systemName: "moon.circle.fill") .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width*0.3, height: UIScreen.main.bounds.width*0.3, alignment: .center)
                                Text("Try again tomorrow")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    .padding(.vertical, 60)
                })
            }
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
