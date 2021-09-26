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
    @Environment(\.sizeCategory) var sizeCategory
    @ScaledMetric var scaleSize: CGFloat = 1
    
    var body: some View {
        CardView(height: 240, content: {
            VStack{
                Text("What values should give a reward?")
                    .font(.title3)
                    .fontWeight(.bold)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                Text("\(Int(lowRange)) to \(Int(highRange))%")
                    .font(.title)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width*0.80, height: scaleSize*55, alignment: .center)
                    .background(Color("darkBlue"))
                    .cornerRadius(10)
                    .padding(5)
                if sizeCategory < ContentSizeCategory.extraLarge {
                    HStack{
                        Text("First Reward at:")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .padding(.all, 2.0)
                        Slider(value: $lowRange, in: 0...190, step: 10)
                            .onChange(of: lowRange, perform: { value in
                                settings.lowBar = lowRange
                            })
                            .padding(8)
                    }
                    .padding(.vertical, 8)
                    HStack{
                        Text("Final Reward at:")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .padding(.all, 2.0)
                        Slider(value: $highRange, in: 0...190, step: 10)
                            .onChange(of: highRange, perform: { value in
                                settings.highBar = highRange
                            })
                            .padding(8)
                    }
                    .padding(.vertical, 8)
                } else {
                    VStack{
                        Text("Low-end Cutoff")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding(2.0)
                            .fixedSize(horizontal: false, vertical: true)
                        Slider(value: $lowRange, in: 0...190, step: 10)
                            .onChange(of: lowRange, perform: { value in
                                settings.lowBar = lowRange
                            })
                            .padding(10)
                        Text("High-end Cutoff")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding(2.0)
                            .fixedSize(horizontal: false, vertical: true)
                        Slider(value: $highRange, in: 0...190, step: 10)
                            .onChange(of: highRange, perform: { value in
                                settings.highBar = highRange
                            })
                            .padding(10)
                    }
                    .padding()
                }
            }
            .frame(width: UIScreen.main.bounds.width*0.9, height: nil, alignment: .center)
            .padding(.vertical, 10)
        })
    }
}

struct RangeChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        RangeChoiceView()
            .environmentObject(SettingsViewModel())
    }
}
