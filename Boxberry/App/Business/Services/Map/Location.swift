//
//  Location.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 20/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import CoreLocation

protocol Location {
    
    typealias Completion = (CLLocation?) -> Void
    
    /// Получает текущее положение (координаты) пользователя
    func requestLocation(completion: Completion?)
}
