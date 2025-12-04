//
//  ContentView.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 3/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView() {
            Tab("Home",systemImage: "house") {
             HomeView()
            }
            Tab("Settings", systemImage: "gear") {
                SettingsView()
            }
        }.tint(Color(CGColor(red: 48/256, green: 242/256, blue: 215/256, alpha: 1)))
    }
}

#Preview {
    ContentView()
}
