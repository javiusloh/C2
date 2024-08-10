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
    @AppStorage ("distanceCount") var distanceCount: Double = getDistance(stepCount)
    func getDistance(Double: stepCount){
        distanceCount = Double(stepCount) * Double(0.71)
    }
    @AppStorage("dayLeft") var dayLeft = 0
    
    @StateObject private var viewModel = StepCounterViewModel()
    var body: some View {
        
        TabView{
            HomeView(stepCount: $viewModel.steps, fish: .constant(0), vegetable: .constant(0), dayLeft: $dayLeft)
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
            ShopView(dayLeft: $dayLeft, stepCount: $viewModel.steps)
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

