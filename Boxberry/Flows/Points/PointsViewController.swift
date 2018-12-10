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
    func didUpdateUserLocation(_ location: CLLocation)
    func didRequestPoints(_ points: [ViewPoint])
}


// MARK: - PointsViewController

class PointsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var mapView: YMKMapView!
    @IBOutlet var northButton: UIButton!
    @IBOutlet var userLocationButton: UIButton!
    @IBOutlet var filterButton: UIButton!
    
    
    // MARK: - Models
    
    var input: PointsViewInput?
    
    
    // MARK: - Fields
    
    lazy var placemarkImage: UIImage! = UIImage(named: "Pin")
    var map: YMKMap {
        return mapView.mapWindow.map
    }
    
    
    // MARK: - IBActions
    
    @IBAction func northButtonAction(_ sender: UIButton) {
        //
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        //
    }
    
    @IBAction func userLocationButtonAction(_ sender: UIButton) {
        //
    }
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input?.viewDidLoad()
        
        addButtonsToMap()

        // Включение / выключение жестов наклона, например, параллельное панорамирование двумя пальцами.
        map.isTiltGesturesEnabled = false
        
        let userLocationLayer = mapView.mapWindow.map.userLocationLayer
        userLocationLayer.isEnabled = true
        userLocationLayer.setObjectListenerWith(self)
    }
    
    @IBAction func buttonTap(_ sender: UIButton) {
        userLocationButton.isHidden = !userLocationButton.isHidden
    }
}


// MARK: - PointsViewOutput

extension PointsViewController: PointsViewOutput {
    
    // MARK: - Points placemarks
    
    func didRequestPoints(_ points: [ViewPoint]) {
        for point in points {
            if let gps = point.gps {
                let target = YMKPoint(latitude: gps.latitude, longitude: gps.longitude)
                let placemark = map.mapObjects.addPlacemark(with: target)
                
                customizePlacemark(placemark)
            }
        }
        
        filterButton.isHidden = false
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
    
    
    // MARK: - User location
    
    func didRequestUserLocation(_ location: CLLocation) {
        locate(to: location)
    }
    
    func didUpdateUserLocation(_ location: CLLocation) {
        let zoom = map.cameraPosition.zoom
        locate(to: location, zoom: zoom)
    }
    
    typealias CameraCompletion = (Bool) -> Void
    
    fileprivate func locate(
        to location: CLLocation,
        zoom: Float? = nil,
        completion: CameraCompletion? = nil) {
        
        let target = YMKPoint(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        
        let zoom = zoom ?? 14
        let camera = YMKCameraPosition(target: target, zoom: zoom, azimuth: 0, tilt: 0)
        let animation = YMKAnimation(type: .smooth, duration: 1)
        
        map.move(
            with: camera,
            animationType: animation,
            cameraCallback: completion
        )
    }
}


// MARK: - YMKUserLocationObjectListener

extension PointsViewController: YMKUserLocationObjectListener {
    func onObjectAdded(with view: YMKUserLocationView) {
        
        let frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let circleFrame = CGRect(x: 2, y: 2, width: 16, height: 16)
        
        let iconView = UIView(frame: frame)
        iconView.backgroundColor = UIColor(hex: 0xF2F2F2)
        iconView.cornerRadius = iconView.bounds.width / 2
        
        let circleView = UIView(frame: circleFrame)
        circleView.cornerRadius = circleView.bounds.width / 2
        circleView.borderWidth = 4
        circleView.borderColor = UIColor(hex: 0x29ABE2)
        circleView.backgroundColor = UIColor(hex: 0x29ABE2)
        
        iconView.addSubview(circleView)
        
        iconView.isOpaque = false
        
        if let viewProvider = YRTViewProvider(uiView: iconView) {
            view.pin.setViewWithView(viewProvider)
        }

        view.accuracyCircle.fillColor = .blue
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {
        //
    }
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {
        //
    }
}


// MARK: - Fileprivate

extension PointsViewController {
    
    fileprivate func addButtonsToMap() {
        createButtons()
        embedMapControlsInStack([northButton, userLocationButton, filterButton])
    }
    
    fileprivate func createButtons() {
        northButton = UIButton.circleButton(forImage: UIImage(named: "North"), radius: 16)
        northButton.addTarget(self, action: #selector(northButtonAction), for: .touchUpInside)
        
        filterButton = UIButton.circleButton(forImage: UIImage(named: "Filter"), radius: 20)
        filterButton.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
        
        userLocationButton = UIButton.circleButton(forImage: UIImage(named: "Arrow"), radius: 16)
        userLocationButton.addTarget(self, action: #selector(userLocationButtonAction), for: .touchUpInside)
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
