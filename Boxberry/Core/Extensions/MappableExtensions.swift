//
//  MappableExtensions.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 02/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import MapKit

extension CLLocationCoordinate2D: Mappable {
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}

extension Array: Mappable where Element: Codable {}
