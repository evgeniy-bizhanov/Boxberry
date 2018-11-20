//
//  Location.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 20/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import CoreLocation

protocol Location {
    
    typealias LocationDelegate = (CLLocation?) -> Void
    
    /// Замыкание-делегат для передачи полученной локации
    var completion: LocationDelegate? { get set }
    
    /// Получает текущее положение (координаты) пользователя
    func fetchUserLocation()
}
