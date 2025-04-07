import Foundation

protocol DistrictRepository {
    static func getDistrictById(_ id: String) async throws -> District;
    static func getFirstDistrict() async throws -> District;
    static func getDistricts(skip: Int, limit: Int) async throws -> [District];
}
