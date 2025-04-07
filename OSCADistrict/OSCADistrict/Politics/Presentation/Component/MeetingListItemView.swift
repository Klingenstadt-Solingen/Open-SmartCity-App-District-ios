import SwiftUI

struct MeetingListItemView: View {
    
    var meeting: PoliticMeeting
    var buttonStlye: GeneralButtonStyle
    
    init(meeting: PoliticMeeting) {
        self.meeting = meeting
        buttonStlye = GeneralButtonStyle()
        if (meeting.startDateTime != nil) && meeting.startDateTime! > Date.now {
            buttonStlye.buttonColor = Color("DisabledColor", bundle: OSCADistrict.bundle)
        }
    }
    
    var body: some View {
        GeneralNavigationLink(route: Route.politicMeetingDetail(meeting)) {
            VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                if let startDateTime = meeting.startDateTime {
                    Text(startDateTime, format: .dateTime.dateOnly())
                        .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                }
                Text(meeting.name)
                    .font(DistrictDesign.Size.Font.SUB_SUB_TITLE)
                MeetingInfoView(meeting: meeting)
            }.padding(DistrictDesign.Padding.MEDIUM)
                .padding(.leading, DistrictDesign.Padding.MEDIUM)
            .frame(maxWidth: .infinity, alignment: .leading)
        }.disabled((meeting.startDateTime != nil) && meeting.startDateTime! > Date.now)
        .buttonStyle(
            buttonStlye
        )
    }
}


#Preview {
    let meeting = PoliticMeeting(
        id: "",
        name: "Test",
        startDateTime: Date.now,
        endDateTime: Date.now,
        location: nil,
        meetingState: PoliticMeetingState.scheduled,
        invitationFile: PoliticFile(
            id: "",
            mimeType: "Test invitation file",
            accessUrl: "",
            downloadUrl: "",
            name: "",
            fileName: "",
            text: "",
            date: Date.now,
            size: 0,
            sha512Checksum: "",
            webUrl: "",
            updatedAt: Date.now,
            createdAt:  Date.now
        ),
        resultsProtocolFile: PoliticFile(
            id: "",
            mimeType: "Test result file",
            accessUrl: "",
            downloadUrl: "",
            name: "",
            fileName: "",
            text: "",
            date: Date.now,
            size: 0,
            sha512Checksum: "",
            webUrl: "",
            updatedAt: Date.now,
            createdAt:  Date.now
        ),
        verbatimProtocolFile: PoliticFile(
            id: "",
            mimeType: "Test verbatim file",
            accessUrl: "",
            downloadUrl: "",
            name: "",
            fileName: "",
            text: "",
            date: Date.now,
            size: 0,
            sha512Checksum: "",
            webUrl: "",
            updatedAt: Date.now,
            createdAt:  Date.now
        ),
        /*auxiliaryFiles: [
            AuxiliaryFile(
              id: "",
              name: "",
              fileName: "",
              text: "",
              date: Date(),
              size: 0,
              sha512Checksum: "",
              mimeType: "",
              accessUrl: "",
              downloadUrl: "",
              webUrl: "",
              updatedAt: Date(),
              createdAt: Date()
            )
          ],*/
        webUrl: "",
        updatedAt: Date.now,
        createdAt:  Date.now
    )
    MeetingListItemView(meeting: meeting)
}

