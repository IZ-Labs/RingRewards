//
//  instructionsView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 9/23/21.
//

import SwiftUI

struct initalSettingsView: View {
    @Binding var isAuthorized: Bool
    
    @EnvironmentObject var settings : SettingsViewModel
    @EnvironmentObject var spinTracker : SpinViewModel
    @Environment(\.sizeCategory) var sizeCategory
    @ScaledMetric var scaleSize: CGFloat = 1
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                SettingsView()
                Button(action: {
                    settings.settingsInitalized = true
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: UIScreen.main.bounds.width*0.28*scaleSize, height: scaleSize*50, alignment: .center)
                            .foregroundColor(.blue)
                            .padding(3)
                        Text("Complete")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                    }.multilineTextAlignment(.trailing)
                }).buttonStyle(BorderlessButtonStyle())
            }
        }
    }
}


struct initalSettingsView_Previews: PreviewProvider {
    @State static var isAuthorized = false
    static var previews: some View {
        initalSettingsView(isAuthorized: $isAuthorized)
            .environmentObject(SettingsViewModel())
    }
}
