//
//  ContentView.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 1
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.systemGray6
    }
    
    var body: some View {
        
        ZStack {
            
            TabView(selection: $selection){
                
                ShortMeView().tabItem {
                    VStack {
                        selection == 1 ? Image("icons8-cut_filled") : Image("icons8-cut")
                        Text("Short Me")
                    } }.tag(1)
                
                HistoryView().tabItem {
                    VStack {
                        selection == 2 ? Image("icons8-past_filled") : Image("icons8-past")
                            .renderingMode(.original)
                        Text("History")
                    } }.tag(2)
                
                InfoView().tabItem {
                    VStack {
                        selection == 3 ? Image("icons8-info_filled") : Image("icons8-info")
                        Text("Info")
                    }
                }.tag(3)
            }
            .accentColor(.pink)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
