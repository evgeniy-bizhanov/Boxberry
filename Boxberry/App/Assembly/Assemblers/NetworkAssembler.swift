//
//  NetworkAssembler.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 25/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire
import Swinject

class NetworkAssembler: Assembly {
    
    func assemble(container: Container) {
        
        container.register(SessionManager.self) { _ in
            return NetworkAssembler.makeSessionManager()
        }.inObjectScope(.container)
    }
    
    /// Создает и конфигурирует менеджер сессий
    private static func makeSessionManager() -> SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        let manager = SessionManager(configuration: configuration)
        return manager
    }
}
