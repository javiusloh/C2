//
//  GoalSettingsView.swift
//  C2
//
//  Created by Nathan Lee Min Hao  on 27/7/24.
//


import SwiftUI

struct GoalSettingsView: View {
    @AppStorage("stepGoal") var stepGoal: Int = 10000
    @AppStorage("distanceGoal") var distanceGoal: Double = 5.0
    
    var body: some View {
        
//        Button {
//            distanceGoal = 5.0
//            stepGoal = 10000
//        }
//        label: {
//            Text(".")
//         }
        
        NavigationStack{
            VStack{
                Stepper("Steps: \(stepGoal)", value: $stepGoal, in: 1...100000, step: 500)
                .padding()
                
                Stepper("Distance: \(distanceGoal.formatted())", value: $distanceGoal, in: 1...500, step: 0.1)

                .padding()
                
                Spacer()
                
                
            }
            .navigationTitle("Goal settings")
        }
            
    }
}

#Preview {
    GoalSettingsView()
}
