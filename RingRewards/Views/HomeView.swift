//
//  ContentView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var settings = SettingsViewModel()
    @StateObject var spinTracker = SpinViewModel()
    
    var body: some View {
        TabView(){
            DispenserView()
                .tabItem {
                Image(systemName: "hare.fill")
                Text("Dispenser")}
            
            resetTestView()
                .tabItem {
                Image(systemName: "die.face.3.fill")
                Text("Debugging")
            }
            
            SettingsView()
                .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
            }
        }
        .environmentObject(settings)
        .environmentObject(spinTracker)
        .coordinateSpace(name: "pullToRefresh")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            
    }
}
