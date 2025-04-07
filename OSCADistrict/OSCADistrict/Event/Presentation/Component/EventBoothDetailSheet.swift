import SwiftUI
import MarkdownUI
import SDWebImageSwiftUI
import CoreLocation

struct EventBoothDetailSheet: View {
    var eventBooth: EventBooth
    @EnvironmentObject var locationViewModel: LocationViewModel
    @StateObject var viewModel = EventBoothDetailViewModel()
    @State var distance: LocalizedStringKey = ""
    
    var body: some View {
        LoadingWrapper(loadingStates: viewModel.loadingState) {
            ScrollView {
                VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                    HStack(alignment: .center, spacing: 0) {
                        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                            Text(eventBooth.type?.name ?? "")
                                .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                            Text(eventBooth.name)
                                .font(DistrictDesign.Size.Font.HEADLINE)
                                .lineLimit(3)
                            
                            Text(viewModel.eventTags.map({ eventTag in
                                eventTag.name
                            }).joined(separator: ", "))
                                .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                        }
                        Spacer()
                        if let url = eventBooth.mainSponsor.icon.url {
                            WebImage(url: URL(string: url))
                                .resizable()
                                .indicator { _, _ in
                                ProgressView()
                            }
                            .transition(.fade)
                            .scaledToFit()
                            .clipShape(DistrictDesign.ROUNDED_RECTANGLE)
                            .frame(maxHeight: 100)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: DistrictDesign.Spacing.BIG) {
                        LocationNavigationView(
                            locationDescription: eventBooth.locationDescription,
                            latitude: eventBooth.geopoint.latitude,
                            longitude: eventBooth.geopoint.longitude
                        )
                        
                        if let content = eventBooth.content {
                            Markdown(content)
                                .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                        }
                    }
                }.padding(DistrictDesign.Padding.BIGGER)
                .frame(alignment: .top)
                
                if viewModel.eventSponsors.count > 0 {
                    ZStack {
                        VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                            EventSponsorPagerView(sponsors: viewModel.eventSponsors)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, DistrictDesign.Padding.MEDIUM)
                        .foregroundColor(.white)
                    }
                    .background(Color.primary.padding(.bottom, -UIScreen.main.bounds.height))
                }
            }
        }.task {
            await viewModel.getEventBoothTags(objectId: eventBooth.id)
            await viewModel.getEventBoothSponsors(objectId: eventBooth.id)
        }
    }
}

#Preview {
    //EventItemDetailSheet()
}
