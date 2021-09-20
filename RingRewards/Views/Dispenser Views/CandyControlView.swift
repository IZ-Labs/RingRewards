//
//  CandyControlView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/28/21.
//

import SwiftUI
import HealthKit

struct CandyControlView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var spinTracker: SpinViewModel
    @State private var hasClicked: Bool = false
    @Environment(\.sizeCategory) var sizeCategory
    @ScaledMetric var scaleSize: CGFloat = 1
    
    var body: some View {
        CardView(height: 275, content: {
            switch spinTracker.numUserSpins {
            case 0:
                if spinTracker.numPossibleSpins != 0 {
                    VStack {
                        Image(systemName: "sunrise.fill")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: scaleSize*130, height: scaleSize*130, alignment: .center)
                        Text("Keep moving and try again later")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }.padding(.vertical, 40)
                    
                } else {
                    VStack {
                        Image(systemName: "sparkles")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: scaleSize*110, height: scaleSize*110, alignment: .center)
                        Text("All rewards redeemed today!\n Try again tomorrow!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }.padding(.vertical, 40)
                }
            case 1...3:
                VStack {
                    Text("Congrats!\n You've earned a reward!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    Button(action: {
                        spinTracker.spin(spins: 1, settings: settings)
                        spinTracker.refreshTasks(settings: settings)
                        hasClicked.toggle()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: UIScreen.main.bounds.width*0.65, height: scaleSize*60, alignment: .center)
                                .foregroundColor(settings.goalColor)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 3))
                                .overlay(Text("Click to redeem")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white))
                                .padding(.all, 3)
                        }
                    })
                }.padding(.vertical, 40)
            default:
                Text("Error - You shouldn't be here")
                    .padding(45)
            }
        })
    }
}

struct CandyControlView_Previews: PreviewProvider {
    static var previews: some View {
        CandyControlView()
            .environmentObject(SettingsViewModel())
            .environmentObject(SpinViewModel())
    }
}
