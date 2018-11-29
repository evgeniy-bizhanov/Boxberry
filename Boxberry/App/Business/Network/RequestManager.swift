//
//  RequestManager.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 24/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

class RequestManager: AbstractRequestManager {
    
    // MARK: - Properties
    
    let errorParser: AbstractErrorParser
    let sessionManager: SessionManager
    let queue: DispatchQueue?

    let url: URL! = URL(string: AppConfig.Network.url)

    
    // MARK: - Functions
    
    // MARK: - Initializers
    
    required init(
        errorParser: AbstractErrorParser,
        sessionManager: SessionManager,
        queue: DispatchQueue?) {
        
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
    
    
}
