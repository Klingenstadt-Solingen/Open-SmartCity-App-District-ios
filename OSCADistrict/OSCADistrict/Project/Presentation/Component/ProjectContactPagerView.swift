import SwiftUI
import SDWebImageSwiftUI

struct ProjectContactPagerView: View {
    @State var selectedTab = 0
    var contacts: [ProjectContact]
    
    var body: some View {
        let semanticsProfile = Text("profile_image", bundle: OSCADistrict.bundle)
        let semanticsOrganisation = Text("organization", bundle: OSCADistrict.bundle) + Text(": ")
        let phoneNumber =  Text("phone_number", bundle: OSCADistrict.bundle)
        let emailAddress = Text("email_address", bundle: OSCADistrict.bundle)
        
        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.BIG) {
            Text("contacts", bundle: OSCADistrict.bundle)
                .font(DistrictDesign.Size.Font.SUB_TITLE.bold())
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            Pager(data: contacts, selectedPage: $selectedTab) { contact in
                VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                    HStack(alignment: .top, spacing: DistrictDesign.Spacing.DEFAULT) {
                        WebImage(url: URL(string: contact.image))
                            .resizable()
                            .indicator { _, _ in
                                ProgressView()
                            }
                            .transition(.fade)
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 170, maxHeight: 170)
                            .clipped()
                            .mask(DistrictDesign.ROUNDED_RECTANGLE)
                            .accessibilityLabel(semanticsProfile).font(DistrictDesign.Size.Font.DEFAULT)
                            .accessibilityAddTraits(.isImage)
                        
                        VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                            Text(contact.name)
                                .font(DistrictDesign.Size.Font.SUB_SUB_TITLE.bold())
                            
                            VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                                phoneNumber
                                    .font(DistrictDesign.Size.Font.NORMAL_TEXT.bold())
                                    .padding(.top, DistrictDesign.Padding.SMALL)
                                if let phoneNumber = URL(string: "tel:\(contact.phoneNumber)") {
                                    Link(destination: phoneNumber){
                                        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                                            Image("ic_right", bundle: OSCADistrict.bundle)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxHeight: DistrictDesign.Size.Icon.SMALL)
                                                .foregroundColor(.accentColor)
                                            Text(contact.phoneNumber).font(DistrictDesign.Size.Font.SMALL_TEXT)
                                        }
                                    }
                                } else {
                                    Text(contact.phoneNumber).font(DistrictDesign.Size.Font.SMALL_TEXT)
                                }
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel(phoneNumber + Text(": ") + Text(contact.phoneNumber)).font(DistrictDesign.Size.Font.SMALL_TEXT)
                            
                            VStack(alignment: .leading, spacing: DistrictDesign.Spacing.DEFAULT) {
                                emailAddress
                                    .font(DistrictDesign.Size.Font.NORMAL_TEXT.bold())
                                    .padding(.top, DistrictDesign.Padding.SMALL)
                                if let emailAddress = URL(string: "mailto:\(contact.email)") {
                                    Link(destination: emailAddress) { // THIS FEATURE ONLY WORKS ON A REAL PHONE
                                        HStack(spacing: DistrictDesign.Spacing.DEFAULT) {
                                            Image("ic_right", bundle: OSCADistrict.bundle)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(maxHeight: DistrictDesign.Size.Icon.SMALL)
                                                .foregroundColor(.accentColor)
                                            Text(contact.email).font(DistrictDesign.Size.Font.SMALL_TEXT)
                                        }
                                    }
                                } else {
                                    Text(contact.email).font(DistrictDesign.Size.Font.SMALL_TEXT)
                                }
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel(phoneNumber + Text(": ") + Text(contact.email)).font(DistrictDesign.Size.Font.SMALL_TEXT)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Text(contact.organization)
                        .font(DistrictDesign.Size.Font.NORMAL_TEXT)
                        .lineLimit(2)
                        .accessibilityLabel(semanticsOrganisation + Text(contact.organization)).font(DistrictDesign.Size.Font.DEFAULT)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, DistrictDesign.Padding.BIGGER)
            }
        }
        .frame(height: 270)
    }
}
