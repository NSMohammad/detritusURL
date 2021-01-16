//
//  ContentView.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = "Short Me"
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.systemGray6
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                TabView(selection: $selection){
                    
                    ShortMeView().tabItem {
                        VStack {
                            Image("icons8-cut")
                            
                            Text("Short Me")
                            
                        } }.tag(1)
                    
                    
                    
                    HistoryView().tabItem {
                        VStack {
                            Image("icons8-past")
                                .renderingMode(.original)
                            Text("History")
                        } }.tag(2)
                        
                    
                    
                    InfoView().tabItem {
                        VStack {
                            Image("icons8-info")
                            Text("Info")
                        }
                    }.tag(3)
                }
                .accentColor(.pink)

        }
            .navigationBarTitle("\(selection)", displayMode: .inline)
            
        }
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
