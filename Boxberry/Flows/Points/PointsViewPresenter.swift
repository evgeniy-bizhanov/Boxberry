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
    
    var locationService: Location?
    var pointsService: PointsRequestFactory?
    
    
    // MARK: - Properties
    // MARK: - Fields
    
    var output: PointsViewOutput?
    
    
    // MARK: - Functions
    
    func viewDidLoad() {
        setupService()
        fetchUserLocation()
        
        // FIXME: - Удалить тестовый код
        pointsService?.listPoints(completion: { response in
            
            guard let value = response.value else {
                return
            }
            
            print(value)
        })
    }
    
    func setupService() {
        locationService?.completion = { [weak self] location in
            
            guard let location = location else {
                return
            }
            
            self?.output?.didFetch(userLocation: location)
        }
    }
    
    func fetchUserLocation() {
        locationService?.fetchUserLocation()
    }
    
    
    // MARK: - Initializers
    
    init(
        output: PointsViewOutput,
        locationService: Location?,
        pointsService: PointsRequestFactory?) {
        
        self.output = output
        self.locationService = locationService
        self.pointsService = pointsService
    }
}
