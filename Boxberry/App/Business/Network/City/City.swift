//
//  City.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 27/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

struct City: Decodable {
    
    /// Код города в boxberry
    let code: String
    
    /// Наименование города
    let name: String
    
    /// Префикс: г - Город, п - Поселок и т.д
    let prefix: String
    
    /// Прием пип
    let receptionLaP: String
    
    /// Выдача пип
    let deliveryLaP: String
    
    /// Прием МиМ
    let reception: String
    
    /// Наличие пункта выдачи заказов
    let pickupPoint: String?
    
    /// Курьерская доставка
    let courierDelivery: String?
    
    /// Прием международных возвратов
    let foreignReceptionReturns: String
    
    /// Наличие терминала
    let terminal: String
    
    /// ИД КЛАДРа
    let kladr: String
    
    /// Регион
    let region: String
    
    /// Код страны
    let countryCode: String
    
    /// Составное уникальное имя
    let uniqName: String
    
    /// Район
    let district: String
}
