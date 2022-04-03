import CoreLocation
import Foundation
import os

struct Location: Identifiable, Codable {
    var id = UUID()
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees

    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}

class GPSTrackModel: ObservableObject {
    @Published var locations: [Location]

    init() {
        // TODO: replace example data with actual loading/saving
        self.locations = [Location(coordinate: CLLocationCoordinate2D(latitude: 50, longitude: 13))]
    }

    func addCurrentLocation() {
        // TODO: add actual current location to list
        self.locations.append(Location(coordinate: CLLocationCoordinate2D(latitude: 12, longitude: 34)))
    }
}
