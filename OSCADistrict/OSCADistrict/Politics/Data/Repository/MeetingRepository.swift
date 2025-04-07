import Foundation
import Factory
import PapyrusCore
import Papyrus


@API
protocol MeetingRepository {
    @GET("/v1/meetings/:id")
    func getById(id: String) async throws  -> PoliticMeeting
    
    @GET("/v1/meetings")
    func findAllBy(page: Int, size: Int, organizationId: String?, endDateTime: String?) async throws  -> [PoliticMeeting]
}

extension Container {
    var meetingRepository: Factory<MeetingRepository> {
        Factory(self) { MeetingRepositoryAPI(provider: self.politicProvider()) }
            .singleton
    }
}
