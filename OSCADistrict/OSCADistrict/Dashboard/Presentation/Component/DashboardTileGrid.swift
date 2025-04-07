import SwiftUI


struct DashboardTileGrid: View {
    @State var tiles: [any DashboardTileWrapper] = [
        WeatherTileWrapper(),
        PoliticsTileWrapper(),
        ProjectTileWrapper(),
        EventTileWrapper(),
        // disabled for now
        //MobilityTileWrapper(),
        PressReleaseTileWrapper(),
        PointOfInterestTileWrapper(),
    ]

    var body: some View {
        LazyVGrid(
            columns: Array(
                repeating: DistrictDesign.GRID_CELLS_ADAPTIVE(),
                count: 2
            ),
            spacing: DistrictDesign.Spacing.BIG
        ) {
            ForEach(tiles, id: \.id) { tile in
                AnyView(tile)
                    .frame(maxHeight: 130)
                    .aspectRatio(0.75, contentMode: .fill)
                    .buttonStyle(GeneralButtonStyle())
            }
        }
    }
}

#Preview {
    DashboardTileGrid()
}
