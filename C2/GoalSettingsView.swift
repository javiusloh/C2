//
//  GoalSettingsView.swift
//  C2
//
//  Created by Nathan Lee Min Hao  on 27/7/24.
//


import SwiftUI

struct GoalSettingsView: View {
    var body: some View {
        
        NavigationStack{
            VStack{
                Text("Steps")
                    .font(.system(size: 17))
                    .frame(maxWidth:.infinity,alignment: .topLeading) .padding()
                    
                
                Text("Distance")
                    .frame(maxWidth: .infinity,alignment: .topLeading)
                    .padding()
                           .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
            
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

