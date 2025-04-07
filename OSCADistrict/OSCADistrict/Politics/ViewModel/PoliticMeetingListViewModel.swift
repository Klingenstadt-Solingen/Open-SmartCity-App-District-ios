import Foundation
import Combine
import Factory

class PoliticMeetingListViewModel: Pageable {
    @Injected(\.meetingRepository) var meetingRepository: MeetingRepository
    typealias PageableItemType = PoliticMeeting
    var pageSize: Int = OSCADistrictSettings.shared.politicPaginationStep
    var pagesLoaded: Int = 0
    var pageableId: String? = nil
    @Published var items: [PoliticMeeting] = []
    @Published var loadingState: LoadingState = .initializing
    var organizationId: String = ""
    var showFuture = false
    
    func fetchData(skip: Int, limit: Int) async throws -> [PoliticMeeting] {
        if !showFuture {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            return try await meetingRepository.findAllBy(page: skip / limit, size: limit, organizationId: organizationId, endDateTime: formatter.string(from: Date.now))
        } else {
            return try await meetingRepository.findAllBy(page: skip / limit, size: limit, organizationId: organizationId, endDateTime: nil)
        }
        
    }
}


extension Container {
    var politicMeetingListViewModel: Factory<PoliticMeetingListViewModel> {
        Factory(self) { PoliticMeetingListViewModel() }.shared
    }
}
