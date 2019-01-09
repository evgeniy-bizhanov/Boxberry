//
//  MapViewDelegate.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 17/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

protocol MapViewDelegate: class {
    
    /// Called when camera position has changed
    func didCameraPositionChanged()
    
    /// Called when azimuth has changed
    func didAzimuthChanged()
    
    /// Called when placemark was tapped
    func didPlacemarkTapped(withUserData data: Any?, _ location: LocationCoordinate)
}
