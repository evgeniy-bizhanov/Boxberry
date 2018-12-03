//
//  CityRequestManager.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 27/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

extension RequestManager: CityRequestProtocol {
    
    func listCities(completion: @escaping Completion<[City]>) {

        let request = CitiesRequest(url: url)
        self.request(request: request, completion: completion)
    }

    func listCitiesFull(completion: @escaping Completion<[City]>) {

        let request = CitiesFullRequest(url: url)
        self.request(request: request, completion: completion)
    }
}

extension RequestManager {
    internal struct CitiesRequest: RequestRouter, RequestParameter {

        // MARK: - Properties

        let url: URL
        let httpMethod: HTTPMethod = .get

        let method: String = "ListCities"
        let parameters: Parameters? = nil

    }

    internal struct CitiesFullRequest: RequestRouter {

        // MARK: - Properties

        let url: URL
        let httpMethod: HTTPMethod = .get

        let method: String = "ListCitiesFull"
        let parameters: Parameters? = nil

    }
}
