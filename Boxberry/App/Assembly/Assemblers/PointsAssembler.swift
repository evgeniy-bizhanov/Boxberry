//
//  PointsAssembler.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 20/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Swinject

class PointsAssembler: Assembly {
    
    func assemble(container: Container) {
        
        // Сервисы
        container.register(Location.self) { _ in
            LocationService()
        }
        
        container.register(PointRequestProtocol.self) { resolver in
            RequestFactoryHelper.makeFactory(RequestManager.self, resolver: resolver)
        }
        
        // Презентер
        container.register(PointsViewInput.self) { resolver, output in
            return PointsViewPresenter(
                output: output,
                locationService: resolver.resolve(Location.self),
                pointsService: resolver.resolve(PointRequestProtocol.self)
            )
        }
    }
}
