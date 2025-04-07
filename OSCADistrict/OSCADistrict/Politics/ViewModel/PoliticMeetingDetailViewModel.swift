import Foundation
import Factory

class PoliticMeetingDetailViewModel: Loadable {
    @Injected(\.agendaRepository) var agendaRepository: AgendaRepository
    @Published var loadingState: LoadingState = .initializing
    @Published var agendItems: [PoliticAgendaItem] = []
    
    func initAgendaItems( meetingId: String) async {
        await getAgendaItems(meetingId: meetingId)
    }
    
    func getAgendaItems(meetingId: String) async {
        await loadingStateScope {
            self.agendItems = try await agendaRepository.findAllBy(page: 0, size: 1000, meetingId: meetingId)
            await MainActor.run {
                loadingState = .loaded
            }
        }
    }
}


extension Container {
    var politicMeetingDetailViewModel: Factory<PoliticMeetingDetailViewModel> {
        Factory(self) { PoliticMeetingDetailViewModel() }.shared
    }
}
