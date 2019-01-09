//
//  PointViewModel.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 28/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Bond
import UIKit

final class PointViewModel: NSObject {
    
    // MARK: - Properties
    
    let address = Observable<String?>(nil)
    let delivery = Observable<Bool>(false)
    let prepaid = Observable<Bool>(false)
    let card = Observable<Bool>(false)
    
    var items = MutableObservableArray<AbstractPointViewItem>([])
    
    
    // MARK: - Fields
    // MARK: - Functions
    // MARK: - Initializers
    
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


// MARK: - UITableViewDataSource

extension PointViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.section]
        let identifier = item.type.identifier
        
        return tableView
            .dequeueReusableCell(withIdentifier: identifier, for: indexPath) { (cell: PointViewCellModel?) in
                guard let cell = cell else {
                    return
                }
                
                if indexPath.row == 0 {
                    cell.titleIsHidden.value = false
                }
                
                cell.title.value = item.label
                cell.value.value = item.collection[indexPath.row]
            }
    }
}
