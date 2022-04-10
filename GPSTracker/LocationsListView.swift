import SwiftUI

struct LocationsListView: View {
    @StateObject var locationsModel = GPSLocationsModel()

    var body: some View {
        List(locationsModel.locations) { location in
            Text("\(location.latitude), \(location.longitude)")
        }
        .navigationTitle("Locations")
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
    }
}
