//
//  Result.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 04/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

enum Result<T>: Error {
    case error(_ error: String)
    case value(_ value: T)
}
