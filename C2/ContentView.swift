//
//  ContentView.swift
//  C2
//
//  Created by Javius Loh on 20/7/24.
//

import SwiftUI

struct ContentView: View {
    @State var stepsGoal = 0
    @AppStorage ("stepCount") var stepCount = 0
    @State var distanceGoal = 10
    @State var distanceCount = 0.5
    @AppStorage("dayLeft") var dayLeft = 0
    @AppStorage ("vegetable") var vegetable = 0
    @AppStorage ("fish") var fish = 0
    
    @StateObject private var viewModel = StepCounterViewModel()
    var body: some View {
        
        TabView{
            HomeView(stepCount: $viewModel.steps, fish: $dayLeft, vegetable: $fish, dayLeft: $vegetable)
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            ShopView(fish: $fish, vegetable: $vegetable, dayLeft: $dayLeft, stepCount: $viewModel.steps)
                .tabItem{
                    Image(systemName: "cart")
                    Text("Shop")
                }
        }
        .task {
            await viewModel.requestAuth()
            try? await viewModel.fetchTodayStepsAndDistance()
        }
    }
}

#Preview {
    ContentView()
}

