//
//  HomeView.swift
//  C2
//
//  Created by Javius Loh on 20/7/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView{
            
            /// LEADERBOARD CODE
            Text("Leaderboard")
                .bold()
                .font(.largeTitle)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
                

            
            HStack {
                Text(" ")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 20))
                Text("STEPS")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.gray)
                Text("DISTANCE")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.gray)
            }
            
            HStack (){
                Text("Darshan")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))
                    .padding()
                
                Text("7643")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))

                Text("4.8")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))


            }
            HStack {
                Text("Javius")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))
                    .padding()
                
                
                Text("7281")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))

                Text("3.5")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))


            }
            HStack {
                Text("You")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))
                    .padding()
                
                Text("6924")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))

                Text("2.4")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))


            }
            HStack {
                Text("John")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))
                    .padding()
                
                Text("6725")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))

                Text("2.3")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))


        }
            HStack {
                Text("Max")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))
                    .padding()
                
                Text("6283")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))

                Text("1.9")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 17))
            }

    
            
            
            
            
        }
    }
}

#Preview {
    HomeView()
}


