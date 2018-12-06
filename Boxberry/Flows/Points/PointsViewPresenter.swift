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
    
    /// Делает запрос точек выдачи заказов для указанной локации
    /// - Parameter location: Название города/локации
    func requestPoints(forLocation location: String)
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
    private var semaphore: DispatchSemaphore?
    private var group = DispatchGroup()
    
    
    // MARK: - Functions
    
    func viewDidLoad() {
        semaphore = DispatchSemaphore(value: 1)
        
        requestCities()
    }
    
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
            
            self?.group.notify(queue: .main) {
                self?.output?.didDecodeUserLocation(location)
            }
        }
    }
    
    func requestPoints(forLocation location: String) {
        
        guard let cityCode = cities?.first(where: { $0.name == location })?.code else {
            return
        }
        
        requestManager?.listPoints(prepaid: true, city: cityCode) { [weak self] response in
            
            guard
                let points = response.value,
                let viewPoints: [ViewPoint] = try? points.map() else {
                // FIXME: Показать пользователю алерт
                return
            }
            
            DispatchQueue.main.async {
                self?.output?.didRequestPoints(viewPoints)
            }
        }
    }
    
    func requestCities() {
        
        group.enter()
        
        requestManager?.listCitiesFull { [weak self] response in
            self?.cities = response.value
            self?.group.leave()
            
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
