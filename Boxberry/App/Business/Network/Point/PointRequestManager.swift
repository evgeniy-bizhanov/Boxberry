//
//  PointRequestManager.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 24/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

extension RequestManager: PointRequestProtocol {
    
    func listPoints(
        prepaid: Bool, city: Int, completion: @escaping Completion<[Point]>) {

        listPointsRequest(
            prepaid: prepaid,
            city: city,
            completion: completion
        )
    }

    func listPoints(
        prepaid: Bool, completion: @escaping Completion<[Point]>) {

        listPointsRequest(
            prepaid: prepaid,
            city: nil,
            completion: completion
        )
    }

    func listPoints(
        city: Int, completion: @escaping Completion<[Point]>) {

        listPointsRequest(
            prepaid: false,
            city: city,
            completion: completion
        )
    }

    func listPoints(
        completion: @escaping Completion<[Point]>) {

        listPointsRequest(
            prepaid: false,
            city: nil,
            completion: completion
        )
    }
    
    fileprivate
    func listPointsRequest(
        prepaid: Bool, city: Int?, completion: @escaping Completion<[Point]>) {

        let listPointsRequest = ListPointsRequest(url: url, prepaid: prepaid, city: city)
        request(request: listPointsRequest, completion: completion)
    }
}

extension RequestManager {
    
    struct ListPointsRequest: RequestRouter {
        
        // MARK: - Properties
        
        let url: URL
        let httpMethod: HTTPMethod = .get
        
        let method: String = "ListPoints"
        var parameters: Parameters? {
            
            var array: Parameters = [:]
            
            // FIXME: - Вынести токен куда нибудь
            array["token"] = "55555.rvpqcfee"
            array["method"] = method
            
            if prepaid {
                array["prepaid"] = 1
            }
            
            if let city = city {
                array["CityCode"] = city
            }
            
            return array
        }
        
        
        // MARK: - Fields
        
        let prepaid: Bool
        let city: Int?
        
    }
}
