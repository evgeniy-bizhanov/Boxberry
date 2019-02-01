//
//  AbstractPointViewItem.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 05/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

protocol AbstractPointViewItem {
    
    /// The type of point section item
    var type: PointViewType { get }
    
    /// Count of elements in collection
    var rowCount: Int { get }
    
    /// Section label
    var label: String { get }
    
    /// Collection of items
    var collection: [String] { get }
}

extension AbstractPointViewItem {
    var rowCount: Int { return collection.count }
    var label: String { return type.rawValue }
}
