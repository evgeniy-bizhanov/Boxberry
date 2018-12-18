//
//  YMKView.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 17/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import YandexMapKit

fileprivate let defaultZoom: Float = 14
fileprivate let defaultAzimuth: Float = 0
fileprivate let defaultTilt: Float = 0

class YMKView: YMKMapView {
    
    typealias Completion = (Bool) -> Void
    typealias PlacemarkCompletion = (YMKPlacemarkMapObject) -> Void
    typealias PlacemarksCompletion = (Int) -> PlacemarkCompletion
    
    // MARK: - Properties
    
    weak var delegate: MapViewDelegate?
    
    
    // MARK: - Fields
    
    private let animation = YMKAnimation(type: .smooth, duration: 0.7)
    private lazy var map = self.mapWindow.map
    
    private lazy var userLocationLayer: YMKUserLocationLayer = {
        let layer = map.userLocationLayer
        layer.isEnabled = true
        
        return layer
    }()
    
    private var placemarks: YMKMapObjectCollection!
    
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        setupView()
        setupListeners()
        layoutLayers()
    }
    
    private func setupView() {
        // Включение / выключение жестов наклона, например, параллельное панорамирование двумя пальцами.
        map.isTiltGesturesEnabled = false
    }
    
    private func setupListeners() {
        self.map.addCameraListener(with: self)
        self.userLocationLayer.setObjectListenerWith(self)
    }
    
    private func layoutLayers() {
        placemarks = map.addObjectLayer(withLayerId: "placemarks")
    }
    
}


// MARK: - Camera

extension YMKView {
    func move(
        to location: LocationCoordinate,
        zoom: Float? = nil, azimuth: Float? = nil, tilt: Float? = nil,
        completion: Completion?) {
        
        let zoom = zoom ?? defaultZoom
        let tilt = tilt ?? defaultTilt
        let azimuth = azimuth ?? defaultAzimuth
        
        let target = YMKPoint(latitude: location.latitude, longitude: location.longitude)
        let camera = YMKCameraPosition(target: target, zoom: zoom, azimuth: azimuth, tilt: tilt)
        
        map.move(with: camera, animationType: animation, cameraCallback: completion)
    }
    
    func moveToDefaultCamera() {}
    
    func moveToDefaultAzimuth() {
        let target = map.cameraPosition.target
        let zoom = map.cameraPosition.zoom
        let tilt = map.cameraPosition.tilt
        
        let camera = YMKCameraPosition(
            target: target,
            zoom: zoom,
            azimuth: defaultAzimuth,
            tilt: tilt
        )
        
        map.move(
            with: camera,
            animationType: animation,
            cameraCallback: nil
        )
    }
}


// MARK: - Map objects

extension YMKView {
    func addPlacemark(forLocation location: LocationCoordinate, didAddPlacemark: PlacemarkCompletion?) {
        let target = YMKPoint(latitude: location.latitude, longitude: location.longitude)
        let placemark = placemarks.addPlacemark(with: target)
        didAddPlacemark?(placemark)
    }
    
    func addPlacemarks(forLocations locations: [LocationCoordinate], didAddPlacemark: PlacemarksCompletion?) {
        
        var index = 0
        locations.forEach { location in
            addPlacemark(forLocation: location, didAddPlacemark: didAddPlacemark?(index))
            index += 1
        }
    }
}

extension YMKView: YMKMapCameraListener {
    func onCameraPositionChanged(
        with map: YMKMap,
        cameraPosition: YMKCameraPosition,
        cameraUpdateSource: YMKCameraUpdateSource,
        finished: Bool) {
        
        if cameraUpdateSource == .gestures {
            delegate?.cameraPositionDidChanged()
            
            if cameraPosition.azimuth != defaultAzimuth {
                delegate?.azimuthDidChanged()
            }
        }
    }
}

// MARK: - YMKUserLocationObjectListener

extension YMKView: YMKUserLocationObjectListener {
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
