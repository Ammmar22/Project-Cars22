

import CoreLocation

class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    @Published var userlocation: CLLocation?
    static let shared = LocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print ("DEBUG: Not determined" )
        case .restricted:
            print ("DEBUG: Restricted")
        case .denied:
            print ("DEBUG: Denied")
        case .authorizedAlways:
            print ("DEBUG: Auth always")
        case .authorizedWhenInUse:
            print ("DEBUG: Auth when in use")
        @unknown default:
            break
            
        }
        
    }
    
    func locationManager(
        _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last
    else { return }
    self.userlocation = location
}
}
    

