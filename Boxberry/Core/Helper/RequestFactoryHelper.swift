//
//  RequestFactoryHelper.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 26/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire
import Swinject

class RequestFactoryHelper {
    /**
     Создает сервисы по их типам
     
     - Parameters:
     - service: Тип сервиса, которых необходимо создать
     - resolver: Контейнер разрешения зависимостей
     */
    static func makeFactory<T: AbstractRequestManager>(_ service: T.Type, resolver: Resolver) -> T {
        
        guard
            let errorParser = resolver.resolve(AbstractErrorParser.self),
            let sessionManager = resolver.resolve(SessionManager.self) else {
                fatalError("Error parser and session manager resolved as nil for some reason")
        }
        
        let sessionQueue = resolver.resolve(DispatchQueue.self)
        
        return T(
            errorParser: errorParser,
            sessionManager: sessionManager,
            queue: sessionQueue
        )
    }
}
