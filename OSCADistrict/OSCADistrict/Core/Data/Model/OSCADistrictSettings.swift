import Foundation
import SDWebImageSVGCoder
import ParseCore
import SDWebImageVideoCoder
import Factory

// TODO: Settings for all
public class OSCADistrictSettings {
    public static let shared = OSCADistrictSettings()
    
    let shortCacheAge = 1200.0
    let mediumCacheAge = 7200.0
    let longCacheAge = 28800.0
    let parsePaginationStep: Int = 100
    let politicPaginationStep: Int = 20
    let minDistanceRange = 1.0
    let maxDistanceRange = 50.0
    public let deeplinkPrefixes = [
        "solingen://district",
        "solingen://events"
    ]
    var sessionToken: String? = nil
    var deeplink: URL? = nil
    var politicsURL: String? = nil
    
    /**
     Initializes Parse if it hasn't been already
     - Parameter url: Parse URL
     - Parameter clientKey: Parse Client Key
     - Parameter appId: Parse Application Id
     */
    public static func initDistrict(
        url: String?,
        clientKey: String?,
        appId: String?,
        sessionToken: String?,
        deeplink: URL?,
        politicsURL: String?
    ) {
        if let politicsURL = politicsURL {
            shared.politicsURL = politicsURL
        }
        shared.deeplink = deeplink
        if ((Parse.currentConfiguration) == nil) {
            let parseConfig = ParseClientConfiguration { config in
                config.applicationId = appId
                config.clientKey = clientKey
                config.server = url ?? ""
                config.networkRetryAttempts = 2
            }
            Parse.initialize(with: parseConfig)
            
            let svgCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(svgCoder)
            let videoCoder = SDImageVideoCoder.shared
            SDImageCodersManager.shared.addCoder(videoCoder)
            
            if let currentUser = PFUser.current() {
                if let sessionToken = sessionToken {
                    if currentUser.sessionToken != sessionToken {
                        do {
                            try PFUser.become(sessionToken)
#if DEBUG
                            print("Switched to user with new session token.")
#endif
                            OSCADistrictSettings.shared.sessionToken = sessionToken
                        } catch (let err) {
#if DEBUG
                            print(err)
                            print("Unable to switch to user with new session token.")
#endif
                            if PFUser.current() == nil {
#if DEBUG
                                print("Performing anonymous login.")
#endif
                                PFAnonymousUtils.logIn()
                            }
                            OSCADistrictSettings.shared.sessionToken = PFUser.current()?.sessionToken
                        }
                    }
                }
            } else {
                if let sessionToken = sessionToken {
                    do {
                        try PFUser.become(sessionToken)
#if DEBUG
                        print("Logged in with session token.")
#endif
                        OSCADistrictSettings.shared.sessionToken = sessionToken
                    } catch (let err) {
#if DEBUG
                        print(err)
                        print("Unable to login with session token.")
#endif
                        PFAnonymousUtils.logIn()
                    }
                } else {
#if DEBUG
                    print("No session token found. Performing anonymous login.")
#endif
                    PFAnonymousUtils.logIn()
                }
                OSCADistrictSettings.shared.sessionToken = PFUser.current()?.sessionToken
            }
        }
    }
    
    // Currently unused needs testing
    public static func standaloneParseInit() {
        var apiData: NSDictionary?
        if let path = Bundle.main.path(forResource: "SupportingFiles/ApiData", ofType: "plist") {
            apiData = NSDictionary(contentsOfFile: path)
        }
        if let apiData = apiData {
            let url: String? = apiData["API_URL"] as? String
            let clientKey: String? = apiData["API_KEY"] as? String
            let appId: String? = apiData["API_APPID"] as? String
            initDistrict(
                url: url,
                clientKey: clientKey,
                appId: appId,
                sessionToken: nil,
                deeplink: nil,
                politicsURL: nil
            )
        }
    }
}
