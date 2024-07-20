import SwiftUI

struct SetScheduleSheetView: View {
    @State private var scheduledDate: Date = Date.now
    @State private var excerciseName: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                TextField("Add excercise... ", text: $excerciseName)
                    .textFieldStyle(.roundedBorder)
                
                DatePicker("Pick a date and time: ", selection: $scheduledDate, in: Date.now...)
                    .datePickerStyle(.graphical)
                
                Spacer()
                Spacer()
                
                Button {
                    // add function here
                    // need to find a data struct to store
                    // excerciseName, scheduledDate
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .foregroundColor(.white)
                }
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 40)))
            }
            //.navigationTitle("Schedule")
        }
        .padding()
    }
}

#Preview {
    SetScheduleSheetView()
}
