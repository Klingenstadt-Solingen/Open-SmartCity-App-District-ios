import SwiftUI

struct AgendaItemView: View {
    var agendaItem: PoliticAgendaItem
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: DistrictDesign.Spacing.DEFAULT) {
            if let number = agendaItem.number {
                Text(number).font(DistrictDesign.Size.Font.DEFAULT)
            }
            Text(agendaItem.name).font(DistrictDesign.Size.Font.DEFAULT)
            Spacer()
        }.padding(.vertical, DistrictDesign.Padding.SMALL)
    }
}


#Preview {
     AgendaItemView(agendaItem: PoliticAgendaItem(
        id: "",
        name: "Agenda",
        order: 1,
        number: "1.",
        startDateTime: Date.now,
        endDateTime: Date.now,
        public: false,
        result: "test",
        resolutionText: "",
        resolutionFile: nil,
        consultationPaper: nil,
        webUrl: "",
        updatedAt: Date.now,
        createdAt: Date.now
     ))
 }
