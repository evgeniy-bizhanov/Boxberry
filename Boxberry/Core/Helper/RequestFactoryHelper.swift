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
        
        let errorParser = resolver.resolve(​AbstractErrorParser​.self)
        let sessionManager = resolver.resolve(SessionManager.self)
        let sessionQueue = resolver.resolve(DispatchQueue.self)
        
        // swiftlint:disable force_unwrapping
        return T(
            errorParser: errorParser!,
            sessionManager: sessionManager!,
            queue: sessionQueue
        )
        // swiftlint:enable force_unwrapping
    }
}
