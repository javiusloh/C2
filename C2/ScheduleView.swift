import SwiftUI

struct ScheduledItem: Identifiable {
    let id = UUID()
    let date: String
    // let contents: [] 
}

struct ScheduleView: View {
    var body: some View {
        NavigationStack {
            
            // list of substances
            List {
                Text("Hello world")
            }
            
            
            // title and toolbars
            .navigationTitle("Schedule")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Button") {
                        print("Pressed")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Edit") {
                        
                    }
                }
            }
            
            Text("blablabla")
                .navigationTitle("again??!!")
        }
    }
}

#Preview {
    ScheduleView()
}
