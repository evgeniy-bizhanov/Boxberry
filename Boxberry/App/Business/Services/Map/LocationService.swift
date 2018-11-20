//
//  LocationService.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 20/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import CoreLocation

class LocationService: NSObject {
    
//    typealias UserLocationCompletionHandler = (CLLocation) -> Void
    
    // MARK: - Properties
    // MARK: - Fields
    
    private lazy var locationManager: CLLocationManager = initLocationManager()
    private var completion: UserLocationCompletionHandler?
    
    
    // MARK: - Functions
    
    private func initLocationManager() -> CLLocationManager {
        
        let manager = CLLocationManager()
        
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        
        return manager
    }
    
    
    // MARK: - Initializers
}

extension LocationService: Location {
    
    func fetchUserLocation(completion: @escaping (CLLocation?) -> Void) {
        self.completion = completion
        locationManager.requestLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        completion?(locations.first)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
