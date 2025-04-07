import SwiftUI

struct WeatherMeasurementView: View {
    var measurement: WeatherMeasurement
    
    var body: some View {
        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
            ZStack {
                if let image = weatherIconDictionary[measurement.name] {
                    Image(image, bundle: OSCADistrict.bundle)
                        .resizable()
                        .scaledToFit()
                        .frame(width: DistrictDesign.Size.Icon.BIGGER, height: DistrictDesign.Size.Icon.BIGGER)
                        .foregroundColor(.white)
                }
            }
            .frame(width: DistrictDesign.Size.Icon.BIGGER, height: DistrictDesign.Size.Icon.BIGGER)
            VStack(alignment: .leading, spacing: 0) {
                Text(measurement.name)
                    .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                HStack(spacing: DistrictDesign.Spacing.SMALL) {
                    Text("\(measurement.value, specifier: "%.2f")")
                        .font(DistrictDesign.Size.Font.HEADLINE)
                        .accessibilityTextContentType(.spreadsheet)
                    Text(measurement.unit)
                        .font(DistrictDesign.Size.Font.SUB_SUB_TITLE)
                    Spacer()
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
        }
        .padding(DistrictDesign.Padding.MEDIUM)
        .background(DistrictDesign.ROUNDED_RECTANGLE.foregroundColor(.primary))
        .accessibilityElement(children: .combine)
    }
}
