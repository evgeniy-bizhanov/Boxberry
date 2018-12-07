//
//  RequestFactory.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 25/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Alamofire

protocol RequestFactory {
    associatedtype TData
    typealias RequestCompletion = (DataResponse<TData>) -> Void
}
