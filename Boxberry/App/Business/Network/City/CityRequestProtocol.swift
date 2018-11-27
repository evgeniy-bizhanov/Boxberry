//
//  CityRequestProtocol.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 27/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

protocol CityRequestProtocol {

    associatedtype TData
    typealias Completion = (DataResponse<TData>) -> Void
    
    /// Получает список городов из базы Boxberry
    func listCities(completion: @escaping Completion)
    
    /// Получает список городов с полной информацией из базы Boxberry
    func listCitiesFull(completion: @escaping Completion)
}
