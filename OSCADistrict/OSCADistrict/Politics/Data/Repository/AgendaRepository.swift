import Foundation
import Factory
import PapyrusCore
import Papyrus

@API
protocol AgendaRepository {
    @GET("/v1/agenda-items/:id")
    func getById(id: String) async throws  -> PoliticAgendaItem
    
    @GET("/v1/agenda-items")
    func findAllBy(page: Int, size: Int, meetingId: String?) async throws  -> [PoliticAgendaItem]
}

extension Container {
    var agendaRepository: Factory<AgendaRepository> {
        Factory(self) { AgendaRepositoryAPI(provider: self.politicProvider()) }
            .singleton
    }
}
