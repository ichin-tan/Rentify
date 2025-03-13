//
//  LocManager.swift
//  Rentify
//
//  Created by CP on 12/03/25.
//

import Foundation
import CoreLocation

class LocManager : NSObject, ObservableObject {
    
    private static var shared : LocManager?
    private let locationManager : CLLocationManager = CLLocationManager()
    @Published var authorizationStatus : CLAuthorizationStatus = .notDetermined
    private let geoCoder = CLGeocoder()
    @Published var fwdGeoLocation : CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    @Published var currentLocation : CLLocation = CLLocation(latitude: 0.0, longitude: 0.0)
    
    static func getInstance() -> LocManager {
        if (shared == nil){
            self.shared = LocManager()
        }
        return self.shared!
    }
    
    private override init() {
        super.init()
        self.checkLocationPermissions()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    private func checkLocationPermissions() {
        
        self.authorizationStatus = self.locationManager.authorizationStatus
        
        switch self.locationManager.authorizationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                print("Location access permitted")
            case .denied:
                print("Location access denied")
                self.locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Approximate location access permitted")
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            @unknown default:
                print("Unknown Authorization status")
        }
    }
    
    func performReverseGeocoding(completion: ((CLPlacemark?) -> ())?) {
        
        self.geoCoder.reverseGeocodeLocation(currentLocation, completionHandler: { (placemarks, error) in
            
            if (error != nil){
               print("Unable to perform reverse geocoding : \(error!)")
                return
            } else {
                completion?(placemarks?.first)
            }
        })
    }
}

extension LocManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        print(#function, "Location authorization has changed : \(manager.authorizationStatus)")
        self.authorizationStatus = manager.authorizationStatus
        
        switch manager.authorizationStatus{
            case .authorizedAlways, .authorizedWhenInUse:
                self.locationManager.startUpdatingLocation()
            case .denied:
                self.locationManager.stopUpdatingLocation()
            case .restricted, .notDetermined:
                self.locationManager.stopUpdatingLocation()
            @unknown default:
                self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations : \(locations)")
        
        if locations.last != nil {
            print("last location : \(locations.last!)")
            self.currentLocation = locations.last!
        } else {
            self.currentLocation = locations.first ?? CLLocation(latitude: 0.0, longitude: 0.0)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Unable to update location : \(error)")
    }

}
