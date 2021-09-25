//
//  HomeView.swift
//  RingRewards
//
//  Created by Iain Zwiebel on 8/22/21.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var settings : SettingsViewModel
    @EnvironmentObject var spinTracker : SpinViewModel
    
    var body: some View {
        TabView(){
            DispenserView()
                .tabItem {
                Image(systemName: "hare.fill")
                Text("Dispenser")
                }
            
            ChanceView()
                .tabItem {
                Image(systemName: "die.face.3.fill")
                Text("Chance")
                }
            
            SettingsView()
                .tabItem {
                Image(systemName: "gearshape.fill")
                Text("Settings")
                }
            
//            resetTestView()
//                .tabItem {
//                Image(systemName: "pencil.and.outline")
//                Text("Debugging")
//                }
        }
        .coordinateSpace(name: "pullToRefresh")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(SettingsViewModel())
            .environmentObject(SpinViewModel())
    }
}
