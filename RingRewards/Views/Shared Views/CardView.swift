//
//  CardView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct CardView<Content: View>: View {
    @ScaledMetric var height: CGFloat
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack{
            content
                .foregroundColor(.white)
        }
        .frame(width: UIScreen.main.bounds.width*0.95, height: nil, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 25).fill(Color.black))
        .padding(2.5)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(height: 250, content:{
            Text("test").foregroundColor(.white)
            
        })
    }
}
