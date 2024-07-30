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
    @State var distanceGoal = 0.0
    
    @StateObject private var viewModel = StepCounterViewModel()
    var body: some View {
        
        TabView{
            HomeView(stepCount: $viewModel.steps)
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            ShopView(stepCount: $viewModel.steps)
                .tabItem{
                    Image(systemName: "cart")
                    Text("Shop")
                }
        }
        .task {
            await viewModel.requestAuth()
            try? await viewModel.fetchTodaySteps()
        }
    }
}

#Preview {
    ContentView()
}

