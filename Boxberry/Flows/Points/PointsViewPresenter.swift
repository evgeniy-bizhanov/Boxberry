//
//  PointsViewPresenter.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 18/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Foundation

protocol PointsViewInput: ViewInput {
    
    /// Запрашивает текущее положение пользователя
    func requestUserLocation()
    
    /// Декодирует текущее положение пользователя
    /// - Parameter coordinate: Координаты пользователя
    func decodeUserLocation(_ coordinate: LocationCoordinate)
}


/// Презентер для представления отображения точек выдачи заказов на карте
class PointsViewPresenter: PointsViewInput {
    
    // MARK: - Services
    
    var geocoder: GeoCodable?
    var locationManager: Location?
    var requestManager: PointsRequestManager?
    
    
    // MARK: - Properties
    
    var output: PointsViewOutput?
    
    
    // MARK: - Functions
    
    func viewDidLoad() {}
    
    func requestUserLocation() {
        
        locationManager?.requestLocation { [weak self] location in
            
            guard let location = location else {
                return
            }
            
            self?.output?.didRequestUserLocation(location)
        }
    }
    
    func decodeUserLocation(_ coordinate: LocationCoordinate) {
        geocoder?.decodeCity(byCoordinate: coordinate) { [weak self] location in
            
            guard let location = location else {
                return
            }
            
            self?.output?.didDecodeUserLocation(location)
        }
    }
    
    
    // MARK: - Initializers
    
    init(
        output: PointsViewOutput,
        geocoder: GeoCodable?,
        locationManager: Location?,
        requestManager: PointsRequestManager?) {
        
        self.output = output
        self.geocoder = geocoder
        self.locationManager = locationManager
        self.requestManager = requestManager
    }
}
