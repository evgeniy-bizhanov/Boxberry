//
//  GeoCoder.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 01/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import MapKit

class GeoCoder: GeoCodable {
    
    // MARK: - Fields
    
    private lazy var geocoder = CLGeocoder()
    
    
    // MARK: - Functions
    
    func decodeCity(
        byCoordinate coordinate: LocationCoordinate, completion: GeoCodableDelegate?) {
        
        let location = CLLocation(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, _) in
            
            // TODO: Handle error
            
            guard
                let placemark = placemarks?.first,
                let locality = placemark.locality else {
                    return
            }
            
            completion?(locality)
        }
    }
    
}
