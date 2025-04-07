import SwiftUI

struct MobilityAddressSearchView: View {
    @EnvironmentObject var mobilityAddressViewModel: MobilityAddressViewModel
    
    var body: some View {
        if (mobilityAddressViewModel.searchText != "") {
            Text("addresses", bundle: OSCADistrict.bundle)
            LoadingWrapper(
                loadingStates: mobilityAddressViewModel.loadingState
            ) {
                ForEach(
                    Array(mobilityAddressViewModel.poiAddresses.enumerated()),
                    id: \.element.id
                ) { index, address in
                    Text(verbatim: address.concatAddress)
                }
            }.task(id: "\(mobilityAddressViewModel.debounceSearchText)") {
                await mobilityAddressViewModel.fetchAddresses()
            }
        }
        Text("favorites", bundle: OSCADistrict.bundle)
        PaginationLoadingWrapper(
            loadingState: mobilityAddressViewModel.loadingState
        ) {
            LazyVStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                ForEach(Array(mobilityAddressViewModel.items.enumerated()), id: \.element.id) { index, favorite in
                    Text(verbatim: favorite.name).task(id: index) {
                        if index == mobilityAddressViewModel.items.endIndex - 1 && mobilityAddressViewModel.items.endIndex % mobilityAddressViewModel.pageSize == 0  {
                            await mobilityAddressViewModel.loadPage()
                        }
                    }
                }
            }
        }.refreshableTask(id: "", pageable: mobilityAddressViewModel)
    }
}
