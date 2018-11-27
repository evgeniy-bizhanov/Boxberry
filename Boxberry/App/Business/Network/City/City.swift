//
//  City.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 27/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

struct City: Decodable {
    let code: String
    let name: String
    let receptionLaP: String
    let deliveryLaP: String
    let reception: String
    let pickupPoint: String?
    let courierDelivery: String?
    let foreignReceptionReturns: String
    let terminal: String
    let kladr: String
    let region: String
    let countryCode: String
    let uniqName: String
    let district: String
    let prefix: String
}
