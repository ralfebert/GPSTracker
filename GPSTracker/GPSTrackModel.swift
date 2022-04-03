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
    let currentLocation = CurrentLocation(isActive: true)
    let locationsDocument = DocumentStore<[Location]>(filename: "locations.json")
    @Published var locations: [Location] = [] {
        didSet {
            self.locationsDocument.document = self.locations
        }
    }

    init() {
        self.locations = self.locationsDocument.document ?? []
    }

    func addCurrentLocation() {
        if let coordinate = currentLocation.location?.coordinate {
            self.locations.append(Location(coordinate: coordinate))
        } else {
            print("no coordinate")
        }
    }
}
