import SwiftUI

@main
struct GPSTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LocationsListView()
            }
        }
    }
}
