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
    
    func didFetch(userLocation location: CLLocation)
}

class PointsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var mapView: YMKMapView!
    
    
    // MARK: - Models
    // MARK: - Services
    // MARK: - Properties
    
    var input: PointsViewInput?
    
    
    // MARK: - Fields
    // MARK: - IBActions
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        input?.viewDidLoad()
    }
    
    
    // MARK: - Initializers
    
}

extension PointsViewController: PointsViewOutput {
    
    func didFetch(userLocation location: CLLocation) {
        
        locate(onLocation: location)
    }
    
    fileprivate func locate(onLocation location: CLLocation) {
        let target = YMKPoint(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        
        let camera = YMKCameraPosition(target: target, zoom: 15, azimuth: 0, tilt: 0)
        
        let animation = YMKAnimation(type: YMKAnimationType.smooth, duration: 1)
        
        mapView.mapWindow.map.move(
            with: camera,
            animationType: animation,
            cameraCallback: nil
        )
    }
}
