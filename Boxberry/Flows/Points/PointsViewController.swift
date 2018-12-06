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
    func didRequestPoints(_ points: [ViewPoint])
}

class PointsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var mapView: YMKMapView!
    
    
    // MARK: - Models
    
    var input: PointsViewInput?
    
    
    // MARK: - Fields
    
    lazy var placemarkImage: UIImage! = UIImage(named: "Pin")
    var map: YMKMap {
        return mapView.mapWindow.map
    }
    
    
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
        input?.requestPoints(forLocation: location)
    }
    
    fileprivate func customizePlacemark(_ placemark: YMKPlacemarkMapObject) {
        let frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor(hex: 0xD4364F)
        view.cornerRadius = view.bounds.width / 2
        view.borderWidth = 2
        view.borderColor = UIColor(hex: 0xF2F2F2)
        
        view.isOpaque = false
        
        if let viewProvider = YRTViewProvider(uiView: view) {
            
            placemark.setViewWithView(viewProvider)
        }
    }
    
    func didRequestPoints(_ points: [ViewPoint]) {
        for point in points {
            if let gps = point.gps {
                let ymkPoint = YMKPoint(latitude: gps.latitude, longitude: gps.longitude)
                let placemark = map.mapObjects.addPlacemark(with: ymkPoint)
                
                customizePlacemark(placemark)
            }
        }
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
