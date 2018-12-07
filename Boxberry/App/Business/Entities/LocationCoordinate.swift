//
//  LocationCoordinate.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 01/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

struct LocationCoordinate: Codable {
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
