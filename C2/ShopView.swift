//Original Code
//import SwiftUI
//
//struct ShopView: View {
//    @State private var alertShownFish = false
//    @State private var alertShownVegetable = false
//    @Binding var stepCount: Int
//    @AppStorage ("fish") var fish = 0
//    @AppStorage ("vegetable") var vegetable = 0
//    @AppStorage ("dayLeft") var dayLeft = 0
//    @AppStorage("stepLeft") private var stepLeft = 0
//    @State var alertShownError = false
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Divider()
//                HStack {
//                    VStack {
//                        Button {
//                            if stepLeft >= 2000{
//                                alertShownFish = true
//                            }
//                            if stepLeft < 2000{
//                                alertShownError = true
//                            }
//                        } label: {
//                            Image("Fish")
//                                .resizable()
//                                .scaledToFit()
//                                .mask(RoundedRectangle(cornerRadius: 16))
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                        }
//                        .alert("Are you sure you want to buy a fish? ", isPresented: $alertShownFish, actions: {
//                            Button {
//                                // No action on cancel
//                            } label: {
//                                Text("Cancel")
//                            }
//                            Button {
//                                if stepCount >= 2000 {
//                                    stepCount -= 2000
//                                    // Make sure stepLeft doesn't exceed stepCount
//                                    if stepLeft > stepCount {
//                                        stepLeft = stepCount
//                                    }
//                                    fish += 1
//                                    dayLeft = fish + vegetable
//                                }
//                            } label: {
//                                Text("Confirm")
//                            }
//                        })
//                        .alert("You do not have enough steps to buy this item ", isPresented: $alertShownError, actions: {
//                            Button {
//                            } label: {
//                                Text("Dismiss")
//                            }
//                        })
//                        Text("Fish")
//                            .font(.title2)
//                        Text("2000 steps")
//                            .foregroundStyle(Color.gray)
//                    }
//                    VStack {
//                        Button {
//                            if stepLeft >= 2000{
//                                alertShownVegetable = true
//                            }
//                            if stepLeft < 2000{
//                                alertShownError = true
//                            }
//                        } label: {
//                            Image("Vegetable")
//                                .resizable()
//                                .scaledToFit()
//                                .mask(RoundedRectangle(cornerRadius: 16))
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                        }
//                        .alert("Are you sure you want to buy vegetable? ", isPresented: $alertShownVegetable, actions: {
//                            Button {
//                                // No action on cancel
//                            } label: {
//                                Text("Cancel")
//                            }
//                            Button {
//                                if stepCount >= 2000 {
//                                    stepCount -= 2000
//                                    // Make sure stepLeft doesn't exceed stepCount
//                                    if stepLeft > stepCount {
//                                        stepLeft = stepCount
//                                    }
//                                    vegetable += 1
//                                    dayLeft = fish + vegetable
//                                }
//                            } label: {
//                                Text("Confirm")
//                            }
//                        })
//                        .alert("You do not have enough steps to buy this item ", isPresented: $alertShownError, actions: {
//                            Button {
//                            } label: {
//                                Text("Dismiss")
//                            }
//                        })
//                        Text("Vegetable")
//                            .font(.title2)
//                        Text("2000 steps")
//                            .foregroundStyle(Color.gray)
//                    }
//                }
//                // For Testing Only (will remove before submitting)
//                VStack{
//                    Text("Fish: \(fish)")
//                    Text("Vegetable: \(vegetable)")
//                    Text("Number of days left: \(dayLeft)")
//                }
//                Spacer()
//            }
//            .navigationTitle("Shop")
//            .toolbar {
//                HStack{
//                    //For Testing Only (Will remove before screen recording)
//                Button{
//                    stepLeft = stepCount
//                    dayLeft = 0
//                    fish = 0
//                    vegetable = 0
//                } label:{
//                    Image(systemName: "restart")
//                        .foregroundStyle(.gray)
//                }
//                .padding()
//                    Text("Steps: \(stepLeft)")
//                }
//            }
//            .onAppear {
//                // Initialize stepLeft only if it has not been set already
//                if stepLeft == 0 {
//                    stepLeft = stepCount
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ShopView(stepCount: .constant(6924))
//}

//Some Issues with ensureing that the button is not clicked repeatedly
import SwiftUI

struct ShopView: View {
    @AppStorage("totalFood") var totalFood = 0
    @State private var alertShownFish = false
    @State private var alertShownVegetable = false
    @Binding var stepCount: Int
    @AppStorage("fish") var fish = 0
    @AppStorage("vegetable") var vegetable = 0
    @AppStorage("stepLeft") private var stepLeft = 0
    @AppStorage("previousStepCount") private var previousStepCount = 0
    @State private var alertShownError = false
    
    @State private var initialStepLeft: Int? = nil // Track initial stepLeft value
    @State private var hasRefreshBeenClicked = false // Track if reset has been clicked
    
    @State private var selectedFood: String? = nil
    @Binding var dayLeft: Int
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                HStack {
                    VStack {
                        Button {
                            if stepLeft >= 2000 {
                                alertShownFish = true
                            } else {
                                alertShownError = true
                            }
                        } label: {
                            Image("Fish")
                                .resizable()
                                .scaledToFit()
                                .mask(RoundedRectangle(cornerRadius: 16))
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .alert("Are you sure you want to buy a fish? ", isPresented: $alertShownFish, actions: {
                            Button {
                                // No action on cancel
                            } label: {
                                Text("Cancel")
                            }
                            Button {
                                if stepLeft >= 2000 {
                                    stepLeft -= 2000
                                    fish += 1
                                    dayLeft = fish + vegetable
                                }
                            } label: {
                                Text("Confirm")
                            }
                        })
                        .alert("You do not have enough steps to buy this item ", isPresented: $alertShownError, actions: {
                            Button {
                            } label: {
                                Text("Dismiss")
                            }
                        })
                        Text("Fish")
                            .font(.title2)
                        Text("2000 steps")
                            .foregroundStyle(Color.gray)
                    }
                    VStack {
                        Button {
                            if stepLeft >= 2000 {
                                alertShownVegetable = true
                            } else {
                                alertShownError = true
                            }
                        } label: {
                            Image("Vegetable")
                                .resizable()
                                .scaledToFit()
                                .mask(RoundedRectangle(cornerRadius: 16))
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .alert("Are you sure you want to buy vegetable? ", isPresented: $alertShownVegetable, actions: {
                            Button {
                                // No action on cancel
                            } label: {
                                Text("Cancel")
                            }
                            Button {
                                if stepLeft >= 2000 {
                                    stepLeft -= 2000
                                    vegetable += 1
                                    dayLeft = fish + vegetable
                                }
                            } label: {
                                Text("Confirm")
                            }
                        })
                        .alert("You do not have enough steps to buy this item ", isPresented: $alertShownError, actions: {
                            Button {
                            } label: {
                                Text("Dismiss")
                            }
                        })
                        Text("Vegetable")
                            .font(.title2)
                        Text("2000 steps")
                            .foregroundStyle(Color.gray)
                    }
                }
                // For Testing Only (will remove before submitting)
                VStack {
                    Text("Fish: \(fish)")
                    Text("Vegetable: \(vegetable)")
                    Text("Number of days left: \(dayLeft)")
                }
                Spacer()
            }
            .navigationTitle("Shop")
            .toolbar {
                HStack {
                    Button {
                        stepLeft = 0
                        fish = 0
                        vegetable = 0
                        dayLeft = 0
                        totalFood = 0
                    } label: {
                        Text("Testing")
                            .foregroundStyle(.gray)
                            .padding()
                    }
                    Button {
                        stepCount = previousStepCount
                        if stepCount > previousStepCount{
                            hasRefreshBeenClicked = true
                        } else{
                            hasRefreshBeenClicked = false
                        }
                        if hasRefreshBeenClicked == true{
                            refreshSteps()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundStyle(.gray)
                    }
                    .padding()
                    .disabled(hasRefreshBeenClicked) // Disable button if already clicked
                    Text("Steps: \(stepLeft)")
                }
            }
            .onAppear {
                // Initialize stepLeft only if it has not been set already
                if stepLeft == 0 {
                    stepLeft = stepCount
                }
                // Store the initial value of stepLeft if not already stored
                if initialStepLeft == nil {
                    initialStepLeft = stepLeft
                }
            }
        }
    }
    
    private func refreshSteps() {
        // Update stepLeft by adding the difference between stepCount and initialStepLeft
        stepLeft = (stepLeft + stepCount)-(2000*(totalFood))
    }
}

#Preview {
    ShopView(stepCount: .constant(6924), dayLeft: .constant(0))
}
