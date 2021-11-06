//
//  onboardingView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 9/17/21.
//

import SwiftUI

struct onboardingView: View {
    @EnvironmentObject var settings : SettingsViewModel
    @EnvironmentObject var spinTracker : SpinViewModel
    @State private var settingsButtonClicked: Bool = false
    @Environment(\.sizeCategory) var sizeCategory
    @ScaledMetric var scaleSize: CGFloat = 1
    
    var body: some View {
        ZStack {
            ScrollView{
                Text("Welcome to Ring Rewards!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(8)
                
                Text("Please complete the steps below to set up the app and start earning rewards for your activity.")
                    .font(.body)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .padding(8)
                    .fixedSize(horizontal: false, vertical: true)
                
                onboardingItemView(instructions: "We need access to your activity data in order dispense your rewards.", image: "heart.text.square", buttonText: "Authorize", fillColor: .red, action: { settings.requestHKAuth() }, isAuthorized: $settings.HKAuth)
                onboardingItemView(instructions: "We need to access your local network in order to communicate with the dispenser.", image: "wifi", buttonText: "Authorize", fillColor: .blue, action: { settings.requestWifiAuth() }, isAuthorized: $settings.wifiAuth)
                onboardingItemView(instructions: "Please enable notifications to allow for reminders when your rewards are about to expire", image: "hourglass", buttonText: "Authorize", fillColor: .secondary, action: { settings.requestNotificationAuth() }, isAuthorized: $settings.notificationsRequested)
                onboardingItemView(instructions: "You'll need to enter some inital settings in order to use the app. Click below to begin", image: "gear", buttonText: "Begin", fillColor: .secondary, action: { settingsButtonClicked = true }, isAuthorized: $settings.settingsInitalized)
                
                Spacer(minLength: 50)
                
                if settings.HKAuth && settings.wifiAuth && settings.settingsInitalized {
                    Button(action: {
                        settings.hasOnboarded = true
                    }, label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: UIScreen.main.bounds.width*0.35*scaleSize, height: scaleSize*50, alignment: .center)
                                .foregroundColor(Color.blue)
                                .padding(3)
                            Text("Complete")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                        }.multilineTextAlignment(.trailing)
                    })
                        .frame(width: UIScreen.main.bounds.width*0.35*scaleSize, height: scaleSize*50, alignment: .center)
                }
            }.frame(width: UIScreen.main.bounds.width*0.95, height: nil, alignment: .center)
            if settingsButtonClicked && !settings.settingsInitalized {
                initalSettingsView(isAuthorized: $settings.settingsInitalized)
            }
        }
    }
}

struct onboardingView_Previews: PreviewProvider {
    static var previews: some View {
        onboardingView()
            .environmentObject(SettingsViewModel())
            .environmentObject(SpinViewModel())
    }
}
