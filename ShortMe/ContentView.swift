//
//  ContentView.swift
//  ShortMe
//
//  Created by MuhaMaD on 10/23/1399 AP.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView(selection: .constant(1),
                content:  {
                    Text("Short Me").tabItem { Text("Short Me") }.tag(1)
                    Text("History").tabItem { Text("History") }.tag(2)
                })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
