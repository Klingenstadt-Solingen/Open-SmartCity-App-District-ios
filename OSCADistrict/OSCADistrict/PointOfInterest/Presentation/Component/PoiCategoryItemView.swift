import SwiftUI

struct PoiCategoryItemView: View {
    var image: String
    var name: String
    
    var body: some View {
        VStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            ZStack{
                Circle()
                    .fill(Color.accentColor)
                    .shadow()
                Image(image(image), bundle: OSCADistrict.bundle)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(Color.primary)
                    .padding(DistrictDesign.Padding.MEDIUM)
            }.frame(width: DistrictDesign.Size.Icon.HUGE, height: DistrictDesign.Size.Icon.HUGE)
            .shadow()
            .padding(.horizontal, DistrictDesign.Padding.MEDIUM)
            
            Text(name).font(DistrictDesign.Size.Font.NORMAL_TEXT).lineLimit(1)
        }.padding(.vertical, DistrictDesign.Padding.SMALL)
    }
    
    // TODO: Remove hard Coded mess
    func image(_ category: String) -> String {
        switch category {
        case "entsorgung15":
            return "ic_wifi"
        case "dienstleistung100":
            return "ic_shopping_bag"
        case "sport26":
            return "ic_outdoor_swing"
        case "sport38":
            return "ic_running_person"
        case "verkehr41":
            return "ic_car_with_plug"
        case "tourismus1":
            return "ic_cloud_with_kite"
        case "parken1":
            return "ic_car_with_p"
        case "uebernachtung3":
            return "ic_bed_with_person"
        case "verkehr18":
            return "ic_construction_barrier"
        case "verwaltung90":
            return "ic_chat_bubles"
        default:
            return "ic_clock"
        }
    }
}


#Preview {
    PoiCategoryItemView(image: "entsorgung15", name: "Cog")
}
