//
//  PointViewModel.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 28/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Bond
import UIKit

final class PointViewModel {
    
    // MARK: - Properties
    
    let address = Observable<String?>(nil)
    let delivery = Observable<Bool>(false)
    let prepaid = Observable<Bool>(false)
    let card = Observable<Bool>(false)
    
    var items = MutableObservableArray<AbstractPointViewItem>([])
}


// MARK: - Decodable

extension PointViewModel: Decodable {
    enum DecodingKeys: String, CodingKey {
        case address = "addressReduce"
        case delivery = "nalKD"
        case prepaid = "onlyPrepaidOrders"
        case card = "acquiring"
        case contact = "phone"
        case schedule = "workSchedule"
        case metro
    }
    
    public convenience init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        
        address.value = try container.decode(String.self, forKey: .address)
        delivery.value = try container.decode(Bool.self, forKey: .delivery)
        prepaid.value = try container.decode(Bool.self, forKey: .prepaid)
        card.value = try container.decode(Bool.self, forKey: .card)
        
        let metro = PointViewItem(.metro, withValues: try container.decode([String].self, forKey: .metro))
        let contact = PointViewItem(.contact, withValues: try container.decode([String].self, forKey: .contact))
        let schedule = PointViewItem(.schedule, withValues: try container.decode([String].self, forKey: .schedule))
        
        items = MutableObservableArray([metro, contact, schedule].compactMap { $0 })
    }
}
