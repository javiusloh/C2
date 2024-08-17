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

class LeaderboardViewModel: ObservableObject {
    @Published var users: [User] = [
        User(name: "Hunter", stepCount: 7643, distance: 4.8),
        User(name: "Maverick", stepCount: 7281, distance: 3.5),
        User(name: "Logan", stepCount: 6725, distance: 2.3),
        User(name: "Zara", stepCount: 6283, distance: 1.9)
    ]
    
    @Published var storedDistance: Double = 0.0  // This should be updated elsewhere in your app
    
    func updateUser(stepCount: Int) {
        if let index = users.firstIndex(where: { $0.name == "You" }) {
            // Update existing user
            users[index].stepCount = stepCount
            users[index].distance = storedDistance
        } else {
            // Add new user with current storedDistance
            let newUser = User(name: "You", stepCount: stepCount, distance: storedDistance)
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
import SwiftUI

struct HomeView: View {
    @Binding var stepCount: Int
    @StateObject private var leaderboardViewModel = LeaderboardViewModel()
    
    @Binding var fish: Int
    @Binding var vegetable: Int
    @Binding var dayLeft: Int
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Fish: \(fish)")
                PetView(fish: $fish, vegetable: $vegetable, dayLeft: $dayLeft)
                StepCounterView()
                
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
            .toolbar {
                ToolbarItem() {
                    Button {
                        // Navigate to GoalSettingsView
                        // (Assuming you will implement navigation or presentation logic here)
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(stepCount: .constant(6924), fish: .constant(0), vegetable: .constant(0), dayLeft: .constant(0))
}
