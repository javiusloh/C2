//
//  GoalSettingsView.swift
//  C2
//
//  Created by Nathan Lee Min Hao  on 27/7/24.
//


import SwiftUI

struct GoalSettingsView: View {
    @AppStorage("stepGoal") var stepGoal = 10000
    @AppStorage("DistanceGoal") var distanceGoal = 5.0
    var body: some View {
        
        Button {
            distanceGoal = 5.0
        }
        label: {
        
         }
        
        NavigationStack{
            VStack{
                Stepper("Steps: \(stepGoal)", onIncrement: {
                    stepGoal += 500
                }, onDecrement: {
                    stepGoal -= 500
                })
                .padding()
                
                
               Stepper("Distance: \(distanceGoal, specifier: "%.2f")", onIncrement: {
                    distanceGoal += 0.1
                }, onDecrement: {
                    distanceGoal -= 0.1
                })
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
    
import SwiftUI

struct GoalSettings: View {
    @State private var currentNumber = 0

    var body: some View {
        VStack {
            Button(action: {
                currentNumber += 1
            }) {
                Text("\(currentNumber)")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

