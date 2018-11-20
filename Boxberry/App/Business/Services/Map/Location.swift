//
//  Location.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 20/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

//
// Работа с локацией
//

import CoreLocation

protocol Location {
    
    typealias UserLocationCompletionHandler = (CLLocation?) -> Void
    
    /// Получает текущее положение (координаты) пользователя
    func fetchUserLocation(completion: @escaping UserLocationCompletionHandler)
}
