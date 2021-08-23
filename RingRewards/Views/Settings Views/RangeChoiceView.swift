//
//  SummaryView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct RangeChoiceView: View {
    var settings: RingViewModel
    @State var lowRange: Double = UserDefaults.standard.double(forKey: "Low Goal")
    @State var highRange: Double = UserDefaults.standard.double(forKey: "High Goal")
    
    var body: some View {
        CardView(height: 270, content: {
            Spacer()
            Text("What values should give a reward?")
                .font(.title3)
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
            Text("\(Int(lowRange)) to \(Int(highRange)) %")
                .font(.title)
                .fontWeight(.bold)
                .frame(width: UIScreen.main.bounds.width*0.80, height: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color("darkBlue"))
                .cornerRadius(6)
                .padding(5)
            HStack{
                Spacer()
                Text("Low-end Cutoff")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.all, 2.0)
                Slider(value: $lowRange, in: 0...190, step: 10)
                    .onChange(of: lowRange, perform: { value in
                        settings.rangeChange(side: "lowEnd", newValue: lowRange)
                    })
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 1.0)
                Spacer()
            }
            HStack(spacing: 1){
                Spacer()
                Text("High-end Cutoff")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .padding(.all, 2.0)
                Slider(value: $highRange, in: 0...190, step: 10)
                    .onChange(of: highRange, perform: { value in
                    settings.rangeChange(side: "highEnd", newValue: highRange)
                })
                    .padding(.all, 1.0)
                Spacer()
            }
            Spacer()
        })
    }
}

struct RangeChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        RangeChoiceView(settings: RingViewModel())
    }
}
