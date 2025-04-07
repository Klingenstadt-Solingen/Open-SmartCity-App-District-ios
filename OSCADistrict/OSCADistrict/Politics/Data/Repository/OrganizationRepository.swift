import Foundation
import Factory
import PapyrusCore
import Papyrus

@API
protocol OrganizationRepository {
    @GET("/v1/organisations/:id")
    func getById(id: String) async throws  -> PoliticOrganization
    
    @GET("/v1/organisations")
    func findAllBy(page: Int, size: Int, districtId: String) async throws  -> [PoliticOrganization]
}

extension Container {
    var organizationRepository: Factory<OrganizationRepository> {
        Factory(self) { OrganizationRepositoryAPI(provider: self.politicProvider()) }
            .singleton
    }
}
