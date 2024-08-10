import SwiftUI

// Enum to represent different user states
enum UserRank: String {
    case first = "1st"
    case second = "2nd"
    case third = "3rd"
    case fourth = "4th"
    case fifth = "5th"
    case others = "Others"
}

// Model to represent a user
struct User: Identifiable {
    let id = UUID()
    let name: String
    var stepCount: Int
    var distance: Double
}

// ObservableObject to manage leaderboard data
class LeaderboardViewModel: ObservableObject {
    @Published var users: [User] = [
        User(name: "Hunter", stepCount: 7643, distance: 4.8),
        User(name: "Maverick", stepCount: 7281, distance: 3.5),
        User(name: "Logan", stepCount: 6725, distance: 2.3),
        User(name: "Zara", stepCount: 6283, distance: 1.9)
    ]
    
    func updateUser(stepCount: Int) {
        if let index = users.firstIndex(where: { $0.name == "You" }) {
            users[index].stepCount = stepCount
        } else {
            let newUser = User(name: "You", stepCount: stepCount, distance: 0.0)
            users.append(newUser)
        }
        users.sort { $0.stepCount > $1.stepCount }
    }
    
    func rank(for user: User) -> UserRank {
        switch user.stepCount {
        case _ where user.stepCount >= 7643:
            return .first
        case _ where user.stepCount >= 7281:
            return .second
        case _ where user.stepCount >= 6725:
            return .third
        case _ where user.stepCount >= 6283:
            return .fourth
        default:
            return .others
        }
    }
}


struct HomeView: View {
    @Binding var stepCount: Int
    @StateObject private var leaderboardViewModel = LeaderboardViewModel()
    
    @State private var selectedFood: String? = nil
    
    @Binding var fish: Int
    @Binding var vegetable: Int
    @Binding var dayLeft: Int
    
    var body: some View {
        NavigationStack{
            ScrollView {
                Text("\(fish)")
                PetView(fish: $fish, vegetable: $vegetable, dayLeft: $dayLeft)
                StepCounterView() // Placeholder for your step counter view
                
                Text("Leaderboard")
                    .bold()
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
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
                
                ForEach(leaderboardViewModel.users) { user in
                    HStack {
                        Text(user.name)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 17))
                            .padding()
                        
                        Text("\(user.stepCount)")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 17))
                        
                        Text(String(format: "%.1f", user.distance))
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 17))
                    }
                    .padding(.vertical, 2)
                }
                .onAppear {
                    leaderboardViewModel.updateUser(stepCount: stepCount)
                }
                .onChange(of: stepCount) { newValue in
                    leaderboardViewModel.updateUser(stepCount: newValue)
                }
            }
            .navigationTitle("Home")
            .toolbar{
                ToolbarItem(){
                    Button{
                        GoalSettingsView()
                    }label: {
                        Image(systemName: "gear")
                    }
                }
            }
        }
    }
}
#Preview {
    HomeView(stepCount: .constant(6924), fish: .constant(0),  vegetable: .constant(0), dayLeft: .constant(0))
}


