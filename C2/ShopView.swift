import SwiftUI

struct ShopView: View {
    @AppStorage("totalFood") var totalFood = 0
    @Binding var fish: Int
    @Binding var vegetable: Int
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
                    Button{
                        dayLeft = 0
                        vegetable = 0
                        fish = 0
                        stepCurrency = stepCount
                    }label:{
                        Text("T")
                    }
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
    ShopView(fish: .constant(6924), vegetable: .constant(0), dayLeft: .constant(0), stepCount: .constant(0))
}
