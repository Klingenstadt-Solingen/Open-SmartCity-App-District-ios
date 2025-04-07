import SwiftUI

struct EventPricesView: View {
    var prices: [EventPrice]
    
    var body: some View {
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
            Text("event_prices", bundle: OSCADistrict.bundle).font(DistrictDesign.Size.Font.SUB_SUB_TITLE).bold()
            ForEach(prices, id: \.self) { price in
                HStack(spacing: DistrictDesign.Spacing.BIG) {
                    Text(price.name).font(DistrictDesign.Size.Font.NORMAL_TEXT)
                    Text("\(price.price)  \(price.priceCurrency)").font(DistrictDesign.Size.Font.NORMAL_TEXT)
                }.frame(maxWidth: .infinity ,alignment: .leading)
            }
        }.frame(maxWidth: .infinity ,alignment: .leading)
    }
}
