import SwiftUI

struct SetScheduleSheetView: View {
    @Binding var scheduledExercises: [ScheduledExercise]
    @State private var scheduledDate: Date = Date.now
    @State private var exerciseName: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            TextField("Add exercise... ", text: $exerciseName)
                .textFieldStyle(.roundedBorder)
            
            DatePicker("Pick a date and time: ", selection: $scheduledDate, in: Date.now...)
                .datePickerStyle(.graphical)
            
            Spacer()
            Spacer()
            
            Button {
                if exerciseName == "" {
                    exerciseName = "Excercise"
                }
                let newExercise = ScheduledExercise(exerciseName: exerciseName, scheduledDate: scheduledDate)
                scheduledExercises.append(newExercise)
                dismiss()
            } label: {
                Text("Save")
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .foregroundColor(.white)
            }
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 40)))
        }
        .padding()
    }
}

//#Preview {
//    SetScheduleSheetView()
//}
