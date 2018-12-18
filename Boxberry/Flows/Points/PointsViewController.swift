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
    
    @IBOutlet var mapView: YMKView!
    @IBOutlet var azimutButton: UIButton!
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var userLocationButton: UIButton!
    
    
    // MARK: - Models
    
    var input: PointsViewInput?
    
    
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
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input?.viewDidLoad()
        
        mapView.delegate = self
        buttonsToMap()
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
                mapView.addPlacemark(forLocation: location, withImage: image)
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
    func cameraPositionDidChanged() {
        userLocationButton.isHidden = false
    }
    
    func azimuthDidChanged() {
        azimutButton.isHidden = false
    }
}


// MARK: - Fileprivate

extension PointsViewController {
    
    fileprivate func buttonsToMap() {
        azimutButton = UIButton.circleButton(forImage: UIImage(named: "North"), radius: 16)
        azimutButton.addTarget(self, action: #selector(azimutAction), for: .touchUpInside)
        
        filterButton = UIButton.circleButton(forImage: UIImage(named: "Filter"), radius: 20)
        filterButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        
        userLocationButton = UIButton.circleButton(forImage: UIImage(named: "Arrow"), radius: 16)
        userLocationButton.addTarget(self, action: #selector(userLocationAction), for: .touchUpInside)
        
        embedMapControlsInStack([azimutButton, userLocationButton, filterButton])
    }
    
    fileprivate func layoutStackView(_ stack: UIStackView) {
        let margins = mapView.layoutMarginsGuide
        
        self.mapView.addSubview(stack)
        
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 6).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.centerYAnchor, constant: 50).isActive = true
    }
    
    fileprivate func embedMapControlsInStack(_ controls: [UIView]) {
        let stack = UIStackView.mapControlsStackView(arrangedSubviews: controls)
        
        self.layoutStackView(stack)
    }
}


// MARK: - Fileprivate fabric

fileprivate extension UIStackView {
    
    static func mapControlsStackView(arrangedSubviews views: [UIView]) -> UIStackView {
        
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .vertical
        stack.spacing = 6
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }
}
