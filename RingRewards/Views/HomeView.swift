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
                    Label("Dispenser", systemImage: "hare.fill")
                }
            
            ChanceView()
                .tabItem {
                    Label("Chance", systemImage: "die.face.3.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
            
            //            resetTestView()
            //                .tabItem {
            //                Image(systemName: "pencil.and.outline")
            //                Text("Debugging")
            //                }
        }
        .coordinateSpace(name: "pullToRefresh")
        .onAppear {
            if #available(iOS 15.0, *) {
                let appearance = UITabBarAppearance()
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
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
