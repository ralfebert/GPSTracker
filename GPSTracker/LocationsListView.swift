import SwiftUI
import MapKit

struct LocationsListView: View {
    @StateObject var locationsModel = GPSLocationsModel()
    @State var mapRegion = MKCoordinateRegion()

    var body: some View {
        Map(
            coordinateRegion: $mapRegion,
            showsUserLocation: true,
            userTrackingMode: .constant(.follow),
            annotationItems: locationsModel.locations,
            annotationContent: { location in
                MapPin(coordinate: location.coordinate)
            }
        )
        .ignoresSafeArea()
        .overlay(
            alignment: .bottom,
            content: {
                BottomBarView(
                    onRecord: {
                        self.locationsModel.addCurrentLocation()
                    },
                    onDelete: {
                        self.locationsModel.removeAll()
                    },
                    onShowList: {
                    }
                )
                .padding()
            }
        )
    }

    @ViewBuilder var addButton: some View {
        Button(
            action: {
                self.locationsModel.addCurrentLocation()
            },
            label: {
                Image(systemName: "plus")
            }
        )
    }
}
