//
//  PointViewModel.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 28/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Bond

struct PointViewModel {
    let address = Observable<String?>(nil)
    let delivery = Observable<Bool>(false)
    let prepaid = Observable<Bool>(false)
    let card = Observable<Bool>(false)
}

extension PointViewModel: Decodable {
    
    enum DecodingKeys: String, CodingKey {
        case address = "addressReduce"
        case delivery = "nalKD"
        case prepaid = "onlyPrepaidOrders"
        case card = "acquiring"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        address.value = try container.decode(String.self, forKey: .address)
        delivery.value = try container.decode(Bool.self, forKey: .delivery)
        prepaid.value = try container.decode(Bool.self, forKey: .prepaid)
        card.value = try container.decode(Bool.self, forKey: .card)
    }
}
