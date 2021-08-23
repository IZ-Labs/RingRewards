//
//  ContentView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView(){
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("darkBlue"), Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                ScrollView(.vertical, showsIndicators: false){
                    VStack{
                        SummaryView()
                    }
                }
            }.tabItem {
                Image(systemName: "hare.fill")
                Text("Dispenser")
            }
            
            ZStack{}.tabItem {
                Image(systemName: "die.face.3.fill")
                Text("Chance")
            }
            
            SettingsView().tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
