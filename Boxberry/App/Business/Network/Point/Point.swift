//
//  Point.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 18/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

struct Point: Mappable {
    
    /// Код в базе boxberry
    let code: String
    
    /// Наименование ПВЗ
    let name: String
    
    /// Полный адрес
    let address: String
    
    /// Телефон или телефоны
    let phone: String
    
    /// График работы
    let workSchedule: String
    
    /// Описание проезда
    let tripDescription: String
    
    /// Срок доставки (срок доставки из Москвы, дней)
    let deliveryPeriod: Int
    
    /// Код города в boxberry
    let cityCode: String
    
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
    
    /// Если значение "Yes" - точка работает только с полностью оплаченными заказами
    let onlyPrepaidOrders: String
    
    /// Короткий адрес
    let addressReduce: String
    
    /// Если значение "Yes" - Есть возможность оплаты платежными (банковскими) картами
    let acquiring: String
    
    /// Если значение "Yes" - Подпись получателя будет хранится в системе boxberry в электронном виде
    let digitalSignature: String
    
    /// Тип пункта выдачи: 1-ПВЗ, 2-СПВЗ
    let typeOfOffice: String
    
    /// Курьерская доставка
    let nalKD: String
    
    /// Станция метро
    let metro: String
    
    /// Ограничение объема
    let volumeLimit: String
    
    /// Ограничение веса, кг
    let loadLimit: String
    
    /// Координаты gps
    let gps: String
}

extension Point: Decodable {
    
    enum DecodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
        case address = "Address"
        case phone = "Phone"
        case workSchedule = "WorkSchedule"
        case tripDescription = "TripDescription"
        case deliveryPeriod = "DeliveryPeriod"
        case cityCode = "CityCode"
        case cityName = "CityName"
        case tariffZone = "TariffZone"
        case settlement = "Settlement"
        case area = "Area"
        case country = "Country"
        case onlyPrepaidOrders = "OnlyPrepaidOrders"
        case addressReduce = "AddressReduce"
        case acquiring = "Acquiring"
        case digitalSignature = "DigitalSignature"
        case typeOfOffice = "TypeOfOffice"
        case nalKD = "NalKD"
        case metro = "Metro"
        case volumeLimit = "VolumeLimit"
        case loadLimit = "LoadLimit"
        case gps = "GPS"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        code = try container.decode(String.self, forKey: .code)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        phone = try container.decode(String.self, forKey: .phone)
        workSchedule = try container.decode(String.self, forKey: .workSchedule)
        tripDescription = try container.decode(String.self, forKey: .tripDescription)
        deliveryPeriod = try container.decode(Int.self, forKey: .deliveryPeriod)
        cityCode = try container.decode(String.self, forKey: .cityCode)
        cityName = try container.decode(String.self, forKey: .cityName)
        tariffZone = try container.decode(String.self, forKey: .tariffZone)
        settlement = try container.decode(String.self, forKey: .settlement)
        area = try container.decode(String.self, forKey: .area)
        country = try container.decode(String.self, forKey: .country)
        onlyPrepaidOrders = try container.decode(String.self, forKey: .onlyPrepaidOrders)
        addressReduce = try container.decode(String.self, forKey: .addressReduce)
        acquiring = try container.decode(String.self, forKey: .acquiring)
        digitalSignature = try container.decode(String.self, forKey: .digitalSignature)
        typeOfOffice = try container.decode(String.self, forKey: .typeOfOffice)
        nalKD = try container.decode(String.self, forKey: .nalKD)
        metro = try container.decode(String.self, forKey: .metro)
        volumeLimit = try container.decode(String.self, forKey: .volumeLimit)
        loadLimit = try container.decode(String.self, forKey: .loadLimit)
        gps = try container.decode(String.self, forKey: .gps)
    }
}
