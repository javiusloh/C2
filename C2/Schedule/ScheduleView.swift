import SwiftUI

struct ScheduledExercise: Identifiable {
    let id = UUID()
    let exerciseName: String
    let scheduledDate: Date
}

struct GroupedExercise: Identifiable {
    let id = UUID()
    let date: Date
    let exercises: [ScheduledExercise]
}

struct ScheduleView: View {
    @State private var scheduledExercises: [ScheduledExercise] = []
    @State private var showSetScheduleSheetView = false
    
    private var groupedExercises: [Date: [ScheduledExercise]] {
        return Dictionary(grouping: scheduledExercises, by: {exercise in
            Calendar.current.startOfDay(for: exercise.scheduledDate)})
    }
    
    private var groupedExercisesArray: [GroupedExercise] {
        groupedExercises.map { GroupedExercise(date: $0.key, exercises: $0.value) }
            .sorted { $0.date < $1.date }
    }
    
    var body: some View {
        NavigationStack {
            
            // list of excercises grouped by date
            List {
                ForEach(groupedExercisesArray) { group in
                    Section(header: Text(group.date, style: .date)) {
                        ForEach(group.exercises) { exercise in
                            HStack {
                                Text(exercise.exerciseName)
                                Spacer()
                                Text(exercise.scheduledDate, style: .time)
                            }
                        }
                    }
                }
            }
            // title and toolbars
            .navigationTitle("Schedule")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") {
                        showSetScheduleSheetView.toggle()
                    }
                    .sheet(isPresented: $showSetScheduleSheetView) {
                        SetScheduleSheetView(scheduledExercises: $scheduledExercises)
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
