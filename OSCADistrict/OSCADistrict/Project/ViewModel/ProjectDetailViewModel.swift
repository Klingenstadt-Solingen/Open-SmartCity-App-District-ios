import SwiftUI

class ProjectDetailViewModel: Loadable {
    @Published var loadingState: LoadingState = .initializing
    @Published var project = Project()
    @Published var contacts: [ProjectContact] = []
    @Published var partners: [ProjectPartner] = []
    @Published var partnerMap : [ProjectPartnerCategory : [ProjectPartner]] = [:]
    
    func getProject(objectId: String) async {
        
        await loadingStateScope {
            let newProject = try await ProjectRepositoryImpl.getProjectById(objectId: objectId)
            let newContacts = try await ProjectContactRepositoryImpl.getProjectContactsByProjectId(objectId: objectId)
            let newPartners = try await ProjectPartnerRepositoryImpl.getProjectPartnersByProjectId(objectId: objectId)
            
        await createPartnerMap(partners: newPartners);
        
            await MainActor.run {
                self.project = newProject
                self.contacts = newContacts
                self.partners = newPartners
            }
        }
    }
    
    private func createPartnerMap(partners : [ProjectPartner]) async {
        var map = partnerMap
        
        for partner in partners {
            if let category = partner.category {
                var list = map[category] ?? []
                list.append(partner)
                
                map[category] = list
            }
        }
        
        
        let mainActorUnmodifiableReferenceMapCopy = map;
        await MainActor.run {
            partnerMap = mainActorUnmodifiableReferenceMapCopy;
        }
    }
}
