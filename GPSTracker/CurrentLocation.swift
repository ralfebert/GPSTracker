import CoreLocation
import os

/// CurrentLocation provides the current GPS location via CLLocationManager as ObservableObject.
///
/// - Meant to be used for 'when the app is in use', NSLocationWhenInUseUsageDescription needs to be
///   set in Info.plist.
///
/// - This can be used by multiple observers but there should be a single manager object for the "isActive" property.
///   If multiple components want to manage isActive, maybe consider creating multiple instances (often
///   you want different precisions in those cases, too, and having multiple CLLocationManager instances seems
///   to be no big deal)
public class CurrentLocation: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    private let log = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "CurrentLocation")

    @Published public var authorizationStatus = CLAuthorizationStatus.notDetermined
    @Published public var location: CLLocation?

    public init(isActive: Bool = false, desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyHundredMeters) {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = desiredAccuracy
        self.isActive = isActive
        self.updateIsActive()
    }

    public var isActive: Bool = false {
        didSet {
            self.updateIsActive()
        }
    }

    private func updateIsActive() {
        self.log.info("CurrentLocation.isActive: \(self.isActive)")
        if self.isActive {
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        } else {
            self.locationManager.stopUpdatingLocation()
        }
    }

    public var isAuthorized: Bool? {
        switch self.authorizationStatus {
        case .notDetermined:
            return .none
        case .restricted, .denied:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        @unknown default:
            os_log("Unknown authorization status: %s", type: .error, String(describing: self.authorizationStatus))
            return .none
        }
    }
}

extension CurrentLocation: CLLocationManagerDelegate {
    public func locationManager(_: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
    }

    public func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            self.log.error("No location in CLLocation")
            return
        }
        self.location = location
    }
}
