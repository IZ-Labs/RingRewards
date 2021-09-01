//
//  CardView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct CardView<Content: View>: View {
    var height: CGFloat
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack{
            content
                .foregroundColor(.white)
        }
        .frame(width: UIScreen.main.bounds.width*0.95, height: height, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 30).fill(Color.black))
        .padding(.all, 3.0)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(height: 250, content:{
            Text("test").foregroundColor(.white)
            
        })
    }
}
