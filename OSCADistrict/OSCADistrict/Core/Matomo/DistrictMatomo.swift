import MatomoTracker

public class DistrictMatomo {
    var matomoLogEnabled = false
    public static var shared = DistrictMatomo()
    public var tracker: MatomoTracker? = nil
    
    public func initTracker(_ tracker: MatomoTracker? = nil, _ matomoLogEnabled: Bool = false) {
        self.matomoLogEnabled = matomoLogEnabled
        if let tracker = tracker {
            self.tracker = tracker
            logMatomo("Core tracker assigned to District Module.")
        } else {
            logMatomo("No tracker passed for District Module Matomo. Initialization required.")
        }
    }
    
    func track(_ path: [String]) {
        if let tracker = tracker {
            tracker.track(view: path)
            logMatomo("Sending path - \(path)")
        }
    }
    
    func trackRoute(_ route: [Route]) {
        var path = ["district"]
        if route.isEmpty {
            path.append("dashboard")
        } else {
            route.forEach { routePath in
                path.append(routePath.description)
            }
        }
        track(path)
    }
    
    func logMatomo(_ string: String) {
        if (matomoLogEnabled) {
            print("Matomo: \(string)")
        }
    }
}
