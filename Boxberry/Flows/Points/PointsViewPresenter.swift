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
    
    
    // MARK: - Properties
    // MARK: - Fields
    
    var output: PointsViewOutput?
    
    
    // MARK: - Functions
    
    func fetchUserLocation() {
        print("fetch user location")
        locationService?.fetchUserLocation(completion: { [weak self] location in
            
            guard let location = location else {
                return
            }
            
            self?.output?.didFetch(userLocation: location)
        })
    }
    
    
    // MARK: - Initializers
    
    init(output: PointsViewOutput, locationService: Location) {
        self.output = output
        self.locationService = locationService
    }
}
