//
//  PetView.swift
//  C2
//
//  Created by Javius Loh on 20/7/24.
//

import SwiftUI

struct PetView: View {
    @State private var selectedFood: String? = nil
    @Binding var fish: Int
    @Binding var vegetable: Int
    @Binding var dayLeft: Int
    @State var alertShownError = false
    @State var alertShownFish = false
    @State var alertShownVegetable = false
    var body: some View {
        VStack{
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
            Button{
                // Handle button press action if needed
            } label: {
                Menu {
                    Button("Vegetable: \(vegetable)"){
                        if vegetable <= 0{
                            alertShownError = true
                        } else {
                            alertShownVegetable = true
                            selectedFood = "Vegetable"
                            dayLeft -= 1
                            // Handle selection of Vegetable
                            print("Vegetable selected")
                        }

                    }
//                        .alert("You do not have enough steps to buy this item ", isPresented: $alertShownError, actions: {
//                            Button {
//                            } label: {
//                                Text("Dismiss")
//                            }
//                        })
//                        .alert("Are you sure you want to feed it a vegetable? ", isPresented: $alertShownVegetable, actions: {
//                            Button {
//                                vegetable -= 1
//                                dayLeft += 5
//                            } label: {
//                                Text("Confirm")
//                            }
//                        })
                    
                    Button("Fish: \(fish)") {
                        if fish <= 0{
                            alertShownError = true
                        } else {
                            alertShownFish = true
                            selectedFood = "Fish"
                            fish -= 1
                            // Handle selection of Fish
                            print("Fish selected")
                        }
                        }

                } label: {
                    Text("Feed!")
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .cornerRadius(16)
                        .padding()
                }
                .alert("You do not have enough food", isPresented: $alertShownError, actions: {
                    Button {
                    } label: {
                        Text("Dismiss")
                    }
                })
                .alert("Are you sure you want to feed it a fish? ", isPresented: $alertShownFish, actions: {
                    Button {
                        fish -= 1
                    } label: {
                        Text("Confirm")
                    }
                })
                .alert("You do not have enough food", isPresented: $alertShownError, actions: {
                    Button {
                    } label: {
                        Text("Dismiss")
                    }
                })
                .alert("Are you sure you want to feed it a vegetable? ", isPresented: $alertShownVegetable, actions: {
                    Button {
                        vegetable -= 1
                        dayLeft += 5
                    } label: {
                        Text("Confirm")
                    }
                })

            }
        }
    }
}

#Preview {
    PetView(fish: .constant(0), vegetable: .constant(0), dayLeft: .constant(0))
}
