//
//  PointsViewController.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 18/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import CoreLocation
import UIKit
import YandexMapKit

protocol PointsViewOutput {
    
    func didRequestUserLocation(_ location: CLLocation)
    func didDecodeUserLocation(_ location: String)
}

class PointsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var mapView: YMKMapView!
    
    
    // MARK: - Models
    
    var input: PointsViewInput?
    
    
    // MARK: - IBActions
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        input?.viewDidLoad()
        input?.requestUserLocation()
    }
}

extension PointsViewController: PointsViewOutput {
    
    func didDecodeUserLocation(_ location: String) {
        print(location)
    }
    
    func didRequestUserLocation(_ location: CLLocation) {
        
        if
            let coordinate: LocationCoordinate = try? location.coordinate.map() {
            
            input?.decodeUserLocation(coordinate)
        }
        
        locate(onLocation: location)
    }
    
    fileprivate func locate(onLocation location: CLLocation) {
        let target = YMKPoint(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        
        let camera = YMKCameraPosition(target: target, zoom: 14, azimuth: 0, tilt: 0)
        
        let animation = YMKAnimation(type: .smooth, duration: 1)
        
        mapView.mapWindow.map.move(
            with: camera,
            animationType: animation,
            cameraCallback: nil
        )
    }
}
