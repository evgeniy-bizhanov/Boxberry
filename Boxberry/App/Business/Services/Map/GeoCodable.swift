//
//  GeoCoderService.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 01/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

protocol GeoCodable {
    
    typealias GeoCodableDelegate = (String?) -> Void
    
    /// Декодирует коордианты в название города
    /// - Parameter coordinate: Координаты для декодирования `LocationCoordinate`
    func decodeCity(byCoordinate coordinate: LocationCoordinate, completion: GeoCodableDelegate?)
}
