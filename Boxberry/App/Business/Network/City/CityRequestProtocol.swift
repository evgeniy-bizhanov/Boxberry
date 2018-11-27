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
    typealias Completion = (TData) -> Void
}
