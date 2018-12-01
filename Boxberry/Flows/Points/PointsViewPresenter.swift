//
//  PointsViewPresenter.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 18/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Foundation

protocol PointsViewInput: ViewInput {
    func fetchUserLocation()
}


/// Презентер для представления отображения точек выдачи заказов на карте
class PointsViewPresenter: PointsViewInput {
    
    // MARK: - Models
    // MARK: - Services
    
    var geocoder: GeoCodable?
    var locationManager: Location?
    var requestManager: (PointRequestProtocol & CityRequestProtocol)?
    
    
    // MARK: - Properties
    // MARK: - Fields
    
    var output: PointsViewOutput?
    
    
    // MARK: - Functions
    
    func viewDidLoad() {
        setupService()
        fetchUserLocation()
        
        // FIXME: - Удалить тестовый код
        requestManager?.listCities(completion: { response in
            
            guard let value = response.value else {
                return
            }
            
//            print(value)
        })
    }
    
    func setupService() {
        locationManager?.completion = { [weak self] location in
            
            guard let location = location else {
                return
            }
            
            self?.output?.didFetch(userLocation: location)
//            self?.decodeLocation(coordinate: location.coordinate)
        }
    }
    
    func decodeLocation(coordinate: LocationCoordinate) {
        geocoder?.decodeCity(byCoordinate: coordinate, completion: { city in
            print(city)
        })
    }
    
    func fetchUserLocation() {
        locationManager?.fetchUserLocation()
    }
    
    
    // MARK: - Initializers
    
    init(
        output: PointsViewOutput,
        geocoder: GeoCodable?,
        locationManager: Location?,
        requestManager: (PointRequestProtocol & CityRequestProtocol)?) {
        
        self.output = output
        self.geocoder = geocoder
        self.locationManager = locationManager
        self.requestManager = requestManager
    }
}
