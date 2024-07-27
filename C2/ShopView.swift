import SwiftUI

struct ShopView: View {
    @State var alertShownFish = false
    @State var alertShownVegetable = false
    @State var totalSteps = 6924
    var body: some View {
        NavigationStack{
            VStack{
                Divider()
                HStack{
                    VStack{
                        Button{
                            alertShownFish = true
                        }label:{
                            Image("Fish")
                                .resizable()
                                .scaledToFit()
                                .mask(RoundedRectangle(cornerRadius: 16))
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .alert("Confirmation", isPresented: $alertShownFish, actions:{
                            Button{
                                
                            }label:{
                                Text("Cancel")
                            }
                            Button{
                                totalSteps -= 2000
                            }label:{
                                Text("Confirm")
                            }
                        })
                        Text("Fish")
                                .font(.title2)
                            Text("2000 steps")
                                .foregroundStyle(Color.gray)
                        }
                    VStack{
                        Button{
                            alertShownVegetable = true
                        }label:{
                            Image("Vegetable")
                                .resizable()
                                .scaledToFit()
                                .mask(RoundedRectangle(cornerRadius: 16))
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .alert("Confirmation", isPresented: $alertShownVegetable, actions:{
                            Button{
                                
                            }label:{
                                Text("Cancel")
                            }
                            Button{
                                totalSteps -= 2000
                            }label:{
                                Text("Confirm")
                            }
                        })
                        Text("Vegetable")
                            .font(.title2)
                        Text("2000 steps")
                            .foregroundStyle(Color.gray)
                    }
                }
                Spacer()
            }
            .navigationTitle("Shop")
            .toolbar{
                Text("Steps: \(totalSteps)")
            }
        }
    }
}

#Preview {
    ShopView()
}
