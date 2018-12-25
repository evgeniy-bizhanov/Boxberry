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

protocol PointsViewOutput: class {
    
    func didRequestUserLocation(_ location: CLLocation)
    func didUpdateUserLocation(_ location: CLLocation)
    func didRequestPoints(_ points: [ViewPoint])
}


// MARK: - PointsViewController

class PointsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: YMKView!
    @IBOutlet weak var azimutButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var userLocationButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    
    
    // MARK: - Models
    
    var input: PointsViewInput?
    
    
    // MARK: - Properties
    
    var onDetailRequest: ((ViewPoint?) -> Void)?
    
    
    // MARK: - Fields
    
    let cardImage = UIImage(named: "Card")
    let prepaidImage = UIImage(named: "Prepaid")
    let deliveryImage = UIImage(named: "Delivery")
    let emptyImage = UIImage(named: "Empty")
    
    
    // MARK: - IBActions
    
    @IBAction func azimutAction(_ sender: UIButton) {
        defer {
            azimutButton.isHidden = true
        }
        
        mapView.moveToDefaultAzimuth()
    }
    
    @IBAction func filterAction(_ sender: UIButton) {
        //
    }
    
    @IBAction func userLocationAction(_ sender: UIButton) {
        input?.requestUserLocation()
    }
    
    @IBAction func callAction(_ sender: Any) {
        print("call")
    }
    
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        
        let velocity = sender.velocity(in: self.callButton)
        
        if velocity.y > 0 {
            self.callButton.isHidden = true
        } else {
            onDetailRequest?(input?.selectedPoint)
        }
    }
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input?.viewDidLoad()
        
        mapView.delegate = self
    }
}


// MARK: - PointsViewOutput

extension PointsViewController: PointsViewOutput {
    
    // MARK: - Points placemarks
    
    func didRequestPoints(_ points: [ViewPoint]) {
        defer {
            filterButton.isHidden = false
        }
        
        points.forEach { point in
            
            let image: UIImage!
            
            if point.nalKD {
                image = deliveryImage
            } else if point.acquiring {
                image = cardImage
            } else if point.onlyPrepaidOrders {
                image = prepaidImage
            } else {
                image = emptyImage
            }
            
            if let location = point.gps {
                mapView.addPlacemark(forLocation: location, withImage: image, userData: point.code)
            }
        }
    }
    
    fileprivate func setupPlacemark(_ placemark: YMKPlacemarkMapObject, withPoint point: ViewPoint) {
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
    
    
    // MARK: - User location
    
    func didRequestUserLocation(_ location: CLLocation) {
        defer {
            userLocationButton.isHidden = true
            azimutButton.isHidden = true
        }
        
        if let location: LocationCoordinate = try? location.coordinate.map() {
            mapView.move(to: location, completion: nil)
        }
    }
    
    func didUpdateUserLocation(_ location: CLLocation) {}
}


// MARK: - MapViewDelegate

extension PointsViewController: MapViewDelegate {
    func didCameraPositionChanged() {
        userLocationButton.isHidden = false
    }
    
    func didAzimuthChanged() {
        azimutButton.isHidden = false
    }
    
    func didPlacemarkTapped(withUserData data: Any?, _ location: LocationCoordinate) {
        input?.selectPoint(withUserData: data) { [weak self] isHidden in
            self?.callButton.isHidden = isHidden
        }
    }
}
