//
//  PointsAssembler.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 20/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Swinject

typealias PointsRequestManager = PointRequestProtocol & CityRequestProtocol

class PointsAssembler: Assembly {
    
    func assemble(container: Container) {
        
        // Сервисы
        container.register(GeoCodable.self) { _ in
            GeoCoder()
        }
        
        container.register(Location.self) { _ in
            LocationService()
        }
        
        container.register(PointsRequestManager.self) { resolver in
            RequestFactoryHelper.makeFactory(RequestManager.self, resolver: resolver)
        }
        
        // Презентер
        container.register(PointsViewInput.self) { resolver, output in
            return PointsViewPresenter(
                output: output,
                geocoder: resolver.resolve(GeoCodable.self),
                locationManager: resolver.resolve(Location.self),
                requestManager: resolver.resolve(PointsRequestManager.self)
            )
        }
    }
}
