//
//  onboardingItemView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 9/17/21.
//

import SwiftUI

struct onboardingItemView: View {
    let instructions: String
    let image: String
    let buttonText: String
    let fillColor: Color
    let action: () -> Void
    @Binding var isAuthorized: Bool
    
    @EnvironmentObject var settings : SettingsViewModel
    @EnvironmentObject var spinTracker : SpinViewModel
    @Environment(\.sizeCategory) var sizeCategory
    @ScaledMetric var scaleSize: CGFloat = 1
    
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center, spacing: nil, content: {
                Spacer()
                Image(systemName: image)
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(fillColor)
                    .frame(width: UIScreen.main.bounds.width*0.2, height: UIScreen.main.bounds.width*0.2, alignment: .center)
                Spacer()
                VStack {
                    Text(instructions)
                        .font(.title3)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    if isAuthorized {
                        Image(systemName: "checkmark.rectangle.fill")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .foregroundColor(.green)
                            .frame(width: UIScreen.main.bounds.width*0.2, height: UIScreen.main.bounds.width*0.15, alignment: .center)
                    } else {
                        Button(action: {
                            action()
                        }, label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: UIScreen.main.bounds.width*0.28*scaleSize, height: scaleSize*50, alignment: .center)
                                    .foregroundColor(.blue)
                                    .padding(3)
                                Text(buttonText)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding()
                            }.multilineTextAlignment(.trailing)
                        })
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                Spacer()
            })
            Spacer()
        }
    }
}

struct onboardingItemView_Previews: PreviewProvider {
    @State static var isAuthorized = true
    static var previews: some View {
        onboardingItemView(instructions: "this is my long list of instructions. Here is what you must do!", image: "heart.text.square", buttonText: "Connect", fillColor: .red, action: {print("test")}, isAuthorized: $isAuthorized)
            
    }
}
