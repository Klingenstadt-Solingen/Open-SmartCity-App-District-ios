import Foundation
import ParseCore

protocol FavoriteLocationRepository {
    static func getFavoriteLocations(_ tag: String?, skip: Int, limit: Int) async throws -> [FavoriteLocation];
    static func addFavoriteLocation(_ favoriteLocation: FavoriteLocation) async throws;
    static func removeFavoriteLocation(_ favoriteLocation: FavoriteLocation) async throws;
}
