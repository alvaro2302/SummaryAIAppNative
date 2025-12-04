import SwiftUI

struct ListCardRecords: View {
    @State var listRecords: [Record] = []
    @State var title: String = ""
    var body: some View {
        if listRecords.isEmpty {
            EmptyRecordsView()
        } else {
            List {
                Section(header: Text(title).font(.title).bold().foregroundStyle(.black)) {
                    
                
                ForEach(listRecords, id: \.id) { record in
                    CardRecord(record: record)
                }
                }
            }.listStyle(.inset)
        }
    }
}

#Preview {
    ListCardRecords(listRecords: [Record(id: "1", title: "Marketing Strategy Q3", transcription: "fdsdsffsdafsdsdfsdf fdsdfsa fdssdffdsdfs dsffdsff  fdsfd fdsf ds fds ", duration: 32),Record(id: "2", title: "Marketing Strategy Q3", transcription: "fdsdsffsdafsdsdfsdf fdsdfsa fdssdffdsdfs dsffdsff  fdsfd fdsf ds fds ", duration: 32)],title: "My Recordings")
}
