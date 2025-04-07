//

protocol POIAddressRepository {
    static func getAddresses(searchText: String?, limit: Int, skip: Int) async throws -> [POIAddress]
}
