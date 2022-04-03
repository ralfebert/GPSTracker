import SwiftUI

struct LocationsListView: View {
    @StateObject var locationsModel = GPSTrackModel()

    var body: some View {
        List(locationsModel.locations) { location in
            Text("\(location.latitude) \(location.longitude)")
        }
        .navigationTitle("Locations")
        .navigationBarItems(trailing: self.addButton)
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
