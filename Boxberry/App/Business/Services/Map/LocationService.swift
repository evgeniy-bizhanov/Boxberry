//
//  LocationService.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 20/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import CoreLocation

class LocationService: NSObject {
    
    // MARK: - Fields
    
    private lazy var locationManager: CLLocationManager = initLocationManager()
    private var completion: Completion?
    
    
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
    
    func requestLocation(completion: Completion?) {
        self.completion = completion
        locationManager.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        completion?(locations.first)
        completion = nil
        
        manager.stopUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
