import Foundation
import MapKit

struct Mechanic: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let photo: String // Name of the photo in the assets

}
