import Foundation
import Factory
import PapyrusCore
import Papyrus

@API
protocol MembershipRepository {
    @GET("/v1/memberships/:id")
    func getById(id: String) async throws  -> PoliticMembership
    
    @GET("/v1/memberships")
    func findAllBy(page: Int, size: Int, organizationId: String?, personId: String?) async throws  -> [PoliticMembership]
}

extension Container {
    var membershipRepository: Factory<MembershipRepository> {
        Factory(self) { MembershipRepositoryAPI(provider: self.politicProvider()) }
    }
}
