import SwiftUI
import Factory

struct PoliticMeetingDetailScreen: View {
    var meeting: PoliticMeeting
    @InjectedObject(\.politicMeetingDetailViewModel) var viewModel
    
    var body: some View {
        VStack(alignment: .leading,spacing: DistrictDesign.Spacing.DEFAULT) {
            Text(meeting.startDateTime!, format: .dateTime.dateOnly())
                .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            Text(meeting.name)
                .font(DistrictDesign.Size.Font.HEADLINE)
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            MeetingInfoView(meeting: meeting)
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            
            if let name = meeting.resultsProtocolFile?.name,
               let downloadUrl = meeting.resultsProtocolFile?.downloadUrl,
               let mimeType = meeting.resultsProtocolFile?.mimeType  {
                MeetingFileItemView(downloadUrl: downloadUrl, name: name, mimeType: mimeType)
                    .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            }
            if let downloadUrl = meeting.invitationFile?.downloadUrl,
               let name = meeting.invitationFile?.name,
               let mimeType = meeting.invitationFile?.mimeType {
                MeetingFileItemView(downloadUrl: downloadUrl, name: name, mimeType: mimeType)
                    .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            }
            if let downloadUrl = meeting.verbatimProtocolFile?.downloadUrl,
               let name = meeting.verbatimProtocolFile?.name,
               let mimeType = meeting.verbatimProtocolFile?.mimeType {
                MeetingFileItemView(downloadUrl: downloadUrl, name: name, mimeType: mimeType)
                    .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            }
            ScrollView {
                VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                    ForEach(viewModel.agendItems) { agendaItem in
                        let agendaItemView = AgendaItemView(agendaItem: agendaItem)
                            .frame(maxWidth: .infinity)
                            .font(DistrictDesign.Size.Font.SUB_SUB_TITLE)
                            .multilineTextAlignment(.leading)
                        if let downloadUrl = agendaItem.consultationPaper?.mainFile?.downloadUrl,
                           let name = agendaItem.consultationPaper?.mainFile?.name,
                           let mimeType = agendaItem.consultationPaper?.mainFile?.mimeType  {
                            let disclosureGroup = DisclosureGroup {
                                VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                                    MeetingFileItemView(downloadUrl: downloadUrl, name: name, mimeType: mimeType)
                                    if let downloadUrl = agendaItem.resolutionFile?.downloadUrl,
                                       let name = agendaItem.resolutionFile?.name,
                                       let mimeType = agendaItem.resolutionFile?.mimeType {
                                        MeetingFileItemView(downloadUrl: downloadUrl, name: name, mimeType: mimeType)
                                    }
                                    if let result = agendaItem.result{
                                        Text("agenda_result \(result)",bundle: OSCADistrict.bundle)
                                            .font(DistrictDesign.Size.Font.DEFAULT)
                                    }
                                    if let resolutionText = agendaItem.resolutionText {
                                        Text(verbatim: resolutionText)
                                            .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                                    }
                                    ForEach(agendaItem.auxiliaryFiles) { auxiliaryFile in
                                        if let downloadUrl = auxiliaryFile.downloadUrl,
                                           let name = auxiliaryFile.name,
                                           let mimeType = auxiliaryFile.mimeType {
                                            MeetingFileItemView(downloadUrl: downloadUrl, name: name, mimeType: mimeType)
                                        }
                                    }
                                }
                            } label: {
                                agendaItemView
                            }
                            if #available(iOS 16.0, *) {
                                disclosureGroup.disclosureGroupStyle(OSCADisclosureGroupStyle())
                            } else {
                                disclosureGroup
                            }
                            
                        } else {
                            agendaItemView
                        }
                    }
                    
                }.frame(maxWidth: .infinity)
                    .padding(.horizontal, DistrictDesign.Padding.BIGGER)
                    .padding(.vertical, DistrictDesign.Padding.MEDIUM)
                    .foregroundColor(Color.black)
            }
        }.task {
            await viewModel.getAgendaItems(meetingId: meeting.id )
        }
    }
}
