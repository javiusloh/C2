//
//  ContentView.swift
//  C2
//
//  Created by Javius Loh on 20/7/24.
//

import SwiftUI

struct ContentView: View {
    @State var todaySteps = 0
    @State var todayDistance = 0.0
    @State var totalSteps = 0
    @State var totalDistance = 0.0
    @State var stepsGoal = 0
    @State var distanceGoal = 0.0
    @State var fish = 0
    @State var vegetable = 0
    @State var daysLeft = 0
    var body: some View {
        
        TabView{
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            ShopView()
                .tabItem{
                    Image(systemName: "cart")
                    Text("Shop")
                }
        }
    }
}

#Preview {
    ContentView()
}

