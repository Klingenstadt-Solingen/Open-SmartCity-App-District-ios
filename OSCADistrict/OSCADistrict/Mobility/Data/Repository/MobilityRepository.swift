import Foundation
import Papyrus
import Factory

@API
protocol MobilityRepository {
    @GET("/v1/mobility-type")
    func getMobilityTypes() async throws -> [MobilityType]
    
    @GET("/v1/mobility/:typeId/:id")
    func getMobilityById(typeId: String, id: String) async throws -> MobilityObjectItem
    
    @GET("/v1/mobility/:typeId")
    func getAllMobilityObject(
        typeId: String,
        lat: Double,
        lon: Double,
        rangeInMeter: Double,
        skip: Int,
        limit: Int
    ) async throws -> [MobilityObjectItem]
}

extension Container {
    var mobilityRepository: Factory<MobilityRepository> {
        Factory(self) { MobilityRepositoryAPI(provider: self.mobilityProvider()) }
    }
}

