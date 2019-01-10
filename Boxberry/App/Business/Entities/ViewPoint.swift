//
//  UIPoint.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 05/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Foundation

struct ViewPoint {
    
    /// Код в базе boxberry
    let code: String
    
    /// Наименование ПВЗ
    let name: String
    
    /// Полный адрес
    let address: String
    
    /// Телефон или телефоны (разделитель - пробел)
    let phone: [String]
    
    /// График работы (разделитель - ',')
    let workSchedule: [String]
    
    /// Описание проезда
    let tripDescription: String
    
    /// Срок доставки (срок доставки из Москвы, дней)
    let deliveryPeriod: Int
    
    /// Наименование города
    let cityName: String
    
    /// Тарифная зона (город отправления - Москва)
    let tariffZone: String
    
    /// Населенный пункт
    let settlement: String
    
    /// Регион
    let area: String
    
    /// Страна
    let country: String
    
    /// Короткий адрес
    let addressReduce: String
    
    /// Станция метро (разделитель - ';')
    let metro: [String]
    
    /// Тип пункта выдачи: 1-ПВЗ, 2-СПВЗ
    let typeOfOffice: String
    
    /// Точка работает только с полностью оплаченными заказами
    let onlyPrepaidOrders: Bool
    
    /// Есть возможность оплаты платежными (банковскими) картами
    let acquiring: Bool
    
    /// Подпись получателя будет хранится в системе boxberry в электронном виде
    let digitalSignature: Bool
    
    /// Курьерская доставка
    let nalKD: Bool
    
    /// Ограничение объема
    let volumeLimit: Float
    
    /// Ограничение веса, кг
    let loadLimit: Float
    
    /// Координаты gps
    let gps: LocationCoordinate?
}

extension ViewPoint: BidirectionalMappable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        code = try container.decode(String.self, forKey: .code)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        
        phone = parseContacts(input: try container.decode(String.self, forKey: .phone))
        metro = parse(try container.decode(String.self, forKey: .metro), delimeter: ";")
        workSchedule = parse(try container.decode(String.self, forKey: .workSchedule))
        
        tripDescription = try container.decode(String.self, forKey: .tripDescription)
        deliveryPeriod = try container.decode(Int.self, forKey: .deliveryPeriod)
        cityName = try container.decode(String.self, forKey: .cityName)
        tariffZone = try container.decode(String.self, forKey: .tariffZone)
        settlement = try container.decode(String.self, forKey: .settlement)
        area = try container.decode(String.self, forKey: .area)
        country = try container.decode(String.self, forKey: .country)
        addressReduce = try container.decode(String.self, forKey: .addressReduce)
        typeOfOffice = try container.decode(String.self, forKey: .typeOfOffice)
        
        onlyPrepaidOrders = try container.decode(String.self, forKey: .onlyPrepaidOrders)
            .uppercased() == "YES" ? true : false
        acquiring = try container.decode(String.self, forKey: .acquiring)
            .uppercased() == "YES" ? true : false
        digitalSignature = try container.decode(String.self, forKey: .digitalSignature)
            .uppercased() == "YES" ? true : false
        nalKD = try container.decode(String.self, forKey: .nalKD)
            .uppercased() == "YES" ? true : false
        
        volumeLimit = Float(try container.decode(String.self, forKey: .volumeLimit)) ?? 0
        loadLimit = Float(try container.decode(String.self, forKey: .loadLimit)) ?? 0
        
        let coordinate = try container.decode(String.self, forKey: .gps)
            .split(separator: ",")
            .map({ Double($0) })
        
        if
            let latitude = coordinate[0],
            let longitude = coordinate[1] {
            gps = LocationCoordinate(latitude: latitude, longitude: longitude)
        } else {
            gps = nil
        }
    }
}

fileprivate func parseContacts(input: String) -> [String] {
    
    return input
        .split(separator: " ")
        .map {
            String($0).asPhoneNumber
        }
}

fileprivate func parse(_ input: String, delimeter: Character = ",") -> [String] {
    return input
        .split(separator: delimeter)
        .map {
            $0.trimmingCharacters(in: [" "])
        }
}
