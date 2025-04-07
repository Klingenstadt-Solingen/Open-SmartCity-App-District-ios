import SwiftUI

class ProjectGridViewModel: Pageable { 
    typealias PageableItemType = Project
    var pageSize: Int = OSCADistrictSettings.shared.parsePaginationStep
    var pagesLoaded: Int = 0
    var pageableId: String? = nil
    @Published var items: [Project] = []
    @Published var loadingState: LoadingState = .initializing
    @Published var projectStatus: ProjectStatus?
    @Published var debounceSearchText = ""
    @Published var searchText = ""
    @Published var status : [ProjectStatus] = []
    var districtState: DistrictState = .all
    
    init() {
        $searchText
            .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
            .assign(to: &$debounceSearchText)
    }
    
    func fetchData(skip: Int, limit: Int) async throws -> [Project] {
        if status.isEmpty {
            await requestStatus()
        }
        return try await ProjectRepositoryImpl.getProjects(
            districtState: districtState,
            skip: skip,
            limit: limit,
            searchText: debounceSearchText,
            status: projectStatus
        )
    }
    
    private func requestStatus() async  {
        do {
            let status = try await ProjectRepositoryImpl.getProjectStatus()
            await MainActor.run {
                self.status = status
            }
        } catch let _ {
        }
    }
}
