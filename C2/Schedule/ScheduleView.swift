import SwiftUI

struct ScheduleView: View {
    
    // @EnvironmentObject var ScheduledExerciseStore: ScheduledExercises
    
    var body: some View {
        
        NavigationStack {
            
            // list of excercises grouped by date
//            List {
//                ForEach(groupedScheduleExcercises) { date, excercises in
//                    Section(header: Text(date, format: .date)) {
//                        ForEach(exercises) { exercise in
//                            Text("\(exercise.exerciseName) - \(exercise.scheduledDate, style: .short)")
//                        }
//                    }
//                }
//            }
            List {
                Text("Hello world")
            }
            
            // title and toolbars
            .navigationTitle("Schedule")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        // insert code
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Edit") {
                        // insert code
                    }
                }
            }
        }
    }
}

#Preview {
    ScheduleView()
}
