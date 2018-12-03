//
//  AbstractRequestParameter.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 03/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

extension RequestParameter where Self: RequestRouter {
    
    func parameters() -> Parameters? {
        
        var parameters = self.parameters ?? Parameters()
        
        parameters["token"] = AppConfig.Network.token
        parameters["method"] = method
        
        return parameters
    }
}
