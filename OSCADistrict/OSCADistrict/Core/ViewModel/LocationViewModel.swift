import SwiftUI
import CoreLocation
import MapKit

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    public enum MapType {
        case GoogleMaps, AppleMaps
    }
    
    let locationManager = CLLocationManager()
    @State var lastLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestLocation()
        lastLocation = locationManager.location
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Must be implemented
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Must be implemented
    }
    
    func openRouteTo(coordinate: CLLocationCoordinate2D, mapType: MapType) {
        switch mapType {
        case .AppleMaps:
            if let url = URL(string: "http://maps.apple.com/?daddr=\(coordinate.latitude),\(coordinate.longitude)&dirflg=w") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        case .GoogleMaps:
            if let url = URL(string: "https://www.google.com/maps/dir/?api=1&destination=\(coordinate.latitude),\(coordinate.longitude)&travelmode=walking") {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    
    func getLocationAuthorized() -> Bool {
        switch (locationManager.authorizationStatus) {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
    
    func getRouteToCoordinate(coordinate: CLLocationCoordinate2D, transportType: MKDirectionsTransportType = .automobile) async -> MKRoute? {
        if let userLocation = locationManager.location {
            let request = MKDirections.Request()
            let routeSource = MKMapItem(placemark: MKPlacemark(coordinate: userLocation.coordinate))
            let routeDestination = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
            request.source = routeSource
            request.destination = routeDestination
            request.transportType = transportType
            let calculatedRoute = try? await MKDirections(request: request).calculate()
            
            return calculatedRoute?.routes.first
        }
        return nil
    }
    
    func getDistanceToCoordinate(coordinate: CLLocation) async -> Double? {
        if let userLocation = locationManager.location {
            return userLocation.distance(from: coordinate)
        }
        return nil
    }
}


