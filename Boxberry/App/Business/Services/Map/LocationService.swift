//
//  LocationService.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 20/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import CoreLocation

class LocationService: NSObject {
    
    // MARK: - Properties
    
    var completion: LocationDelegate?
    
    
    // MARK: - Fields
    
    private lazy var locationManager: CLLocationManager = initLocationManager()
    private var didFindLocation = false
    
    
    // MARK: - Functions
    
    private func initLocationManager() -> CLLocationManager {
        
        let manager = CLLocationManager()
        
        manager.requestWhenInUseAuthorization()
        
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.delegate = self
        
        return manager
    }
    
    
    // MARK: - Initializers
}

extension LocationService: Location {
    
    func fetchUserLocation() {
        didFindLocation = false
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if didFindLocation {
            return
        }
        
        didFindLocation = true
        
        manager.stopUpdatingLocation()
        completion?(locations.first)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
