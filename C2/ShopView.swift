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
//    @AppStorage("stepCurrency") private var stepCurrency = 0
//    @State var alertShownError = false
//
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Divider()
//                HStack {
//                    VStack {
//                        Button {
//                            if stepCurrency >= 2000{
//                                alertShownFish = true
//                            }
//                            if stepCurrency < 2000{
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
//                                    // Make sure stepCurrency doesn't exceed stepCount
//                                    if stepCurrency > stepCount {
//                                        stepCurrency = stepCount
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
//                            if stepCurrency >= 2000{
//                                alertShownVegetable = true
//                            }
//                            if stepCurrency < 2000{
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
//                                    // Make sure stepCurrency doesn't exceed stepCount
//                                    if stepCurrency > stepCount {
//                                        stepCurrency = stepCount
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
//                    stepCurrency = stepCount
//                    dayLeft = 0
//                    fish = 0
//                    vegetable = 0
//                } label:{
//                    Image(systemName: "restart")
//                        .foregroundStyle(.gray)
//                }
//                .padding()
//                    Text("Steps: \(stepCurrency)")
//                }
//            }
//            .onAppear {
//                // Initialize stepCurrency only if it has not been set already
//                if stepCurrency == 0 {
//                    stepCurrency = stepCount
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
//import SwiftUI
//
//struct ShopView: View {
//    @AppStorage("totalFood") var totalFood = 0
//    @State private var alertShownFish = false
//    @State private var alertShownVegetable = false
//    @AppStorage("fish") var fish = 0
//    @AppStorage("vegetable") var vegetable = 0
//    @AppStorage("previousStepCount") private var previousStepCount = 0
//    @State private var alertShownError = false
//    
//    @State private var initialStepLeft: Int? = nil // Track initial stepCurrency value
//    @State private var hasRefreshBeenClicked = false // Track if reset has been clicked
//    @Binding var stepCount: Int
//    @AppStorage("stepCurrency") private var stepCurrency = 0
//    @AppStorage("stepSync") private var stepSync = 0
//
//    @State private var selectedFood: String? = nil
//    @Binding var dayLeft: Int
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Divider()
//                HStack {
//                    VStack {
//                        Button {
//                            if stepCurrency >= 2000 {
//                                alertShownFish = true
//                            } else {
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
//                                if stepCurrency >= 2000 {
//                                    stepCurrency -= 2000
//                                    fish += 1
//                                    dayLeft = fish + vegetable
//                                    totalFood += 1
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
//                            if stepCurrency >= 2000 {
//                                alertShownVegetable = true
//                            } else {
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
//                                if stepCurrency >= 2000 {
//                                    stepCurrency -= 2000
//                                    vegetable += 1
//                                    dayLeft = fish + vegetable
//                                    totalFood += 1
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
//                VStack {
//                    Text("Fish: \(fish)")
//                    Text("Vegetable: \(vegetable)")
//                    Text("Number of days left: \(dayLeft)")
//                }
//                Spacer()
//            }
//            .navigationTitle("Shop")
//            .toolbar {
//                HStack {
//                    Button {
//                        stepCurrency = 0
//                        fish = 0
//                        vegetable = 0
//                        dayLeft = 0
//                        totalFood = 0
//                    } label: {
//                        Text("TEST")
//                            .foregroundStyle(.gray)
//                            .padding()
//                    }
//                    Button {
//                        
////                        if stepSync != stepCount{
////                            stepSync = stepCount
////                        }
//                        stepCount = previousStepCount
//                        if stepCount > previousStepCount{
//                            hasRefreshBeenClicked = true
//                        } else{
//                            hasRefreshBeenClicked = false
//                        }
//                        if hasRefreshBeenClicked == true{
//                            refreshSteps()
//                        }
//                    } label: {
//                        Image(systemName: "arrow.clockwise")
//                            .foregroundStyle(.gray)
//                    }
//                    .padding()
//                    .disabled(hasRefreshBeenClicked) // Disable button if already clicked
//                    Text("Steps: \(stepCurrency)")
//                }
//            }
//            .onAppear {
//                // Initialize stepCurrency only if it has not been set already
//                if stepCurrency == 0 {
//                    stepCurrency = stepCount
//                }
//                // Store the initial value of stepCurrency if not already stored
//                if initialStepLeft == nil {
//                    initialStepLeft = stepCurrency
//                }
//            }
//        }
//    }
//    
//    private func refreshSteps() {
//        // Update stepCurrency by adding the difference between stepCount and initialStepLeft
//        stepCurrency = stepSync-(2000*(totalFood))
//    }
//}
//
//#Preview {
//    ShopView(stepCount: .constant(6924), dayLeft: .constant(0))
//}





//
import SwiftUI

struct ShopView: View {
    @AppStorage("totalFood") var totalFood = 0
    @AppStorage("fish") var fish = 0
    @AppStorage("vegetable") var vegetable = 0
    @State private var selectedFood: String? = nil
    @Binding var dayLeft: Int
        
    @State private var alertShownFish = false
    @State private var alertShownVegetable = false
    @State private var alertShownError = false
    
    @AppStorage("previousStepCount") private var previousStepCount = 0
    @State private var initialStepLeft: Int? = nil // Track initial stepCurrency value
    
    @Binding var stepCount: Int
    @AppStorage("stepCurrency") private var stepCurrency = 0
    @AppStorage("stepComparism") private var stepComparison = 0
    @AppStorage("stepSync") private var stepDifference = 0
    
    @State private var hasRefreshBeenClicked = false // Track if reset has been clicked
    
    func refreshSteps(){
        if stepCount != stepComparison{
            stepDifference = stepCount - stepComparison
            stepCurrency = stepCount + stepDifference
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider()
                HStack {
                    VStack {
                        Button {
                            if stepCurrency >= 2000 {
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
                                if stepCurrency >= 2000 {
                                    stepCurrency -= 2000
                                    fish += 1
                                    dayLeft = fish + vegetable
                                    totalFood += 1
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
                            if stepCurrency >= 2000 {
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
                                if stepCurrency >= 2000 {
                                    stepCurrency -= 2000
                                    vegetable += 1
                                    dayLeft = fish + vegetable
                                    totalFood += 1
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
                        if hasRefreshBeenClicked ==  false{
                            refreshSteps()
                            hasRefreshBeenClicked = true
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundStyle(.gray)
                    }
                    .padding()
                    .disabled(hasRefreshBeenClicked) // Disable button if already clicked
                    Text("Steps: \(stepCurrency)")
                }
            }
            .onAppear {
                // Initialize stepCurrency only if it has not been set already
                if stepCurrency == 0 {
                    stepCurrency = stepCount
                }
                // Store the initial value of stepCurrency if not already stored
                if initialStepLeft == nil {
                    initialStepLeft = stepCurrency
                }
            }
        }
    }
}

#Preview {
    ShopView(dayLeft: .constant(0), stepCount: .constant(6924))
}
