//
//  PointsViewPresenter.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 18/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

// 1. Запрос городов (группа)
// 2. Запрос положения пользователя
// |- 3. Декодируем положение пользователя
// |- 4. Получаем код города из списка городов (группа)
// |- 5. Запрос пунктов выдачи заказов

import Foundation

protocol PointsViewInput: ViewInput {
    
    func requestUserLocation()
}


/// Презентер для представления отображения точек выдачи заказов на карте
class PointsViewPresenter: PointsViewInput {
    
    // MARK: - Services
    
    var geocoder: GeoCodable?
    var locationManager: Location?
    var requestManager: PointsRequestManager?
    
    
    // MARK: - Properties
    
    var output: PointsViewOutput?
    
    
    // MARK: - Fields
    private var cities: [City]?
    private var points: [Point]?
    private var group = DispatchGroup()
    
    
    // MARK: - Functions
    
    func viewDidLoad() {
        requestCities()
        requestUserLocation()
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


extension PointsViewPresenter {

    // MARK: - Location manager
    
    func requestUserLocation() {
        
        locationManager?.requestLocation { [weak self] location in
            guard
                let self = self,
                let location = location,
                let coordinate: LocationCoordinate = try? location.coordinate.map() else {
                    return
            }
            
            self.decodeUserLocation(coordinate)
            self.output?.didRequestUserLocation(location)
        }
    }
    
    func decodeUserLocation(_ coordinate: LocationCoordinate) {
        
        geocoder?.decodeCity(byCoordinate: coordinate) { [weak self] city in
            guard
                let self = self,
                let city = city else {
                return
            }
            
            // Thread synchronization
            self.group.notify(queue: .global(qos: .userInteractive)) {
                guard let cityCode = self.cities?.first(where: { $0.name == city })?.code else {
                    return
                }
                
                self.requestPoints(withCode: cityCode)
            }
        }
    }
    
    
    //MARK: - Network request manager
    
    func requestCities() {
        
        group.enter()
        requestManager?.listCitiesFull { [weak self] response in
            guard
                let self = self else {
                    return
            }
            
            self.cities = response.value
            self.group.leave()
        }
    }
    
    func requestPoints(withCode cityCode: String) {
        
        requestManager?.listPoints(prepaid: true, city: cityCode) { [weak self] response in
            guard
                let self = self,
                let points = response.value,
                let viewPoints: [ViewPoint] = try? points.map() else {
                    // FIXME: Показать пользователю алерт
                    return
            }
            
            DispatchQueue.main.async {
                self.output?.didRequestPoints(viewPoints)
            }
        }
    }
}
