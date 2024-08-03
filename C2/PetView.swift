//
//  PetView.swift
//  C2
//
//  Created by Javius Loh on 20/7/24.
//

import SwiftUI

struct PetView: View {
    @Binding var dayLeft: Int
    var body: some View {
        if dayLeft != 0{
            Text("Hungry in \(dayLeft) days")
        } else if dayLeft == 0{
            Text("Pet is hungry! Please feed him.")
        }
        if dayLeft >= 6{
            Image("Happy Jaguar 2")
                .resizable()
                .frame(width: 350, height: 360)
        } else if dayLeft >= 2{
            Image ("Emotionless Jaguar 2")
                .resizable()
                .frame(width: 350, height: 360)
        } else if dayLeft < 2{
            Image ("Crying Jaguar 2")
                .resizable()
                .frame(width: 350, height: 360)
        }
    }
}

#Preview {
    PetView(dayLeft: .constant(0))
}
