//
//  CityRequestManager.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 27/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

extension RequestManager: CityRequestProtocol {

    func listCities(completion: @escaping ([City]) -> Void) {
        
        let request = CitiesRequest(url: url)
    }
    
    func listCitiesFull(completion: @escaping ([City]) -> Void) {
        let request = CitiesFullRequest(url: url)
    }
    
}

extension RequestManager {
    internal struct CitiesRequest: RequestRouter {
        
        // MARK: - Properties
        
        let url: URL
        let httpMethod: HTTPMethod = .get
        
        let method: String = "ListCities"
        let parameters: Parameters? = [
            // FIXME: - Убрать токен
            "token": "55555.rvpqcfee",
            "method": "ListCities"
        ]
        
    }
    
    internal struct CitiesFullRequest: RequestRouter {
        
        // MARK: - Properties
        
        let url: URL
        let httpMethod: HTTPMethod = .get
        
        let method: String = "ListCitiesFull"
        let parameters: Parameters? = [
            // FIXME: - Убрать токен
            "token": "55555.rvpqcfee",
            "method": "ListCitiesFull"
        ]
        
    }
}
