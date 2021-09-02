//
//  RangeChoiceView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct RangeChoiceView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @State var lowRange: Double = UserDefaults.standard.double(forKey: "lowBar")
    @State var highRange: Double = UserDefaults.standard.double(forKey: "highBar")
    
    var body: some View {
        CardView(height: 230, content: {
            Text("What values should give a reward?")
                .font(.title3)
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
            Text("\(Int(lowRange)) to \(Int(highRange))%")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color.white)
                .frame(width: UIScreen.main.bounds.width*0.80, height: 55, alignment: .center)
                .background(Color("darkBlue"))
                .cornerRadius(10)
                .padding(5)
            HStack{
                Spacer()
                Text("Low-end Cutoff")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.all, 2.0)
                Slider(value: $lowRange, in: 0...190, step: 10)
                    .onChange(of: lowRange, perform: { value in
                        settings.lowBar = lowRange
                    })
                    .padding(.all, 1.0)
                Spacer()
            }.frame(width: UIScreen.main.bounds.width*0.9, height: 40, alignment: .center)
            HStack{
                Spacer()
                Text("High-end Cutoff")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.all, 2.0)
                Slider(value: $highRange, in: 0...190, step: 10)
                    .onChange(of: highRange, perform: { value in
                        settings.highBar = highRange
                })
                    .padding(.all, 1.0)
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width*0.9, height: 35, alignment: .center)
        })
    }
}

struct RangeChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        RangeChoiceView()
            .environmentObject(SettingsViewModel())
    }
}
