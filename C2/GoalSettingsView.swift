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
                Text("")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.leading)
            }
            .navigationTitle("Goal settings")
        }
            
    }
}
   



#Preview {
    GoalSettingsView()
}
