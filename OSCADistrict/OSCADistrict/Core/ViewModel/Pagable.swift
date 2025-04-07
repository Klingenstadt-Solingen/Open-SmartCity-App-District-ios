import Foundation
import SwiftUI

public protocol Pageable<PageableItemType>: Loadable {
    associatedtype PageableItemType: Identifiable
    
    var pageSize: Int { get set }
    var pagesLoaded: Int { get set }
    var items: [PageableItemType] { get set }
    var pageableId: String? { get set }
    
    
    func initPageable() async
    func loadPage(pageIndex: Int?) async
    func fetchData(skip: Int, limit: Int) async throws -> [PageableItemType]
    func reset()
}


extension Pageable {
    func initPageable() async {
        await loadingStateScope {
            reset()
            items = try await fetchData(skip: 0, limit: pageSize)
            if items.isEmpty {
                throw ApiError.noResult
            }
        }
    }
    
    func loadPage(pageIndex: Int? = nil) async {
        await paginationStateScope {
            var loadPage = 0
            if let pageIndex = pageIndex {
                loadPage = pageIndex
            } else {
                pagesLoaded += 1
                loadPage = pagesLoaded
            }
            let newItems = try await fetchData(skip: loadPage * pageSize, limit: pageSize)
            let at = pageSize * loadPage
            if at >= self.items.endIndex {
                self.items.append(contentsOf: newItems)
            } else {
                self.items.replaceSubrange(at ..< (at + newItems.count), with: newItems)
            }
        }
    }
    
    func reset() {
        items.removeAll()
        pagesLoaded = .zero
    }
    
    func paginationStateScope(_ block: () async throws -> Void) async {
        await updateLoadingState(.paginating)
        try? await block()
        await updateLoadingState(.loaded)
    }
}
