//
//  IPChoiceView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/27/21.
//

import SwiftUI

struct IPChoiceView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @State var ipVal: String = UserDefaults.standard.string(forKey: "ipVal") ?? "198.168.0.108"
    
    var body: some View {
        CardView(height: 140, content: {
            Text("What is the IP address of the ESP8266?")
                .font(.headline)
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
            TextField("192.168.0.108", text: $ipVal, onCommit:{
                settings.ipVal = ipVal
            })
            .font(.system(size: 20, weight: .medium, design: .default))
            .frame(width: UIScreen.main.bounds.width*0.80, height: 55, alignment: .center)
            .foregroundColor(.white)
            .background(Color("darkBlue"))
            .cornerRadius(10)
            .padding(5)
            .multilineTextAlignment(.center)
        })
    }
}

struct IPChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        IPChoiceView()
            .environmentObject(SettingsViewModel())
    }
}
