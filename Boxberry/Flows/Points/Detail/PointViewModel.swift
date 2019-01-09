//
//  PointViewModel.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 28/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Bond
import UIKit

final class PointViewModel: NSObject, Decodable {
    let address = Observable<String?>(nil)
    let delivery = Observable<Bool>(false)
    let prepaid = Observable<Bool>(false)
    let card = Observable<Bool>(false)
    
    var items = MutableObservableArray<AbstractPointViewItem>([])
    
    public init(from decoder: Decoder) throws {
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

extension PointViewModel {
    enum DecodingKeys: String, CodingKey {
        case address = "addressReduce"
        case delivery = "nalKD"
        case prepaid = "onlyPrepaidOrders"
        case card = "acquiring"
        case contact = "phone"
        case schedule = "workSchedule"
        case metro
    }
}

protocol UITableViewItem: class {
    var item: Observable<String?> { get }
    var isLabelHidden: Observable<Bool> { get }
}

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
            .dequeueReusableCell(UITableViewItem.self, withIdentifier: identifier, for: indexPath) { cell in
                guard let cell = cell else {
                    return nil
                }
                
                if indexPath.row == 0 {
                    cell.isLabelHidden.value = false
                }
                
                cell.item.value = item.collection[indexPath.row]
                // TODO: Сделать без return
                return cell
            }
    }
}
