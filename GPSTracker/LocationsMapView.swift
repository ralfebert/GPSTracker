import MapKit
import SwiftUI

struct LocationsMapView: View {
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
                self.bottomBar
                    .padding()
            }
        )
    }

    @ViewBuilder var bottomBar: some View {
        HStack {
            Group {
                CircleButtonView(imageName: "trash") {
                    // TODO:
                }
                RecordButton {
                    self.locationsModel.addCurrentLocation()
                }
                CircleButtonView(imageName: "list.bullet") {
                    // TODO:
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 40)
        .padding(.vertical, 15)
        .background(.thinMaterial)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 1)
    }
}
