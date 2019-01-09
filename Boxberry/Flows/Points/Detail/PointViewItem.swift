//
//  PointViewItem.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 05/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

struct PointViewItem: AbstractPointViewItem {
    
    // MARK: - Properties
    
    var type: PointViewType
    var collection: [String]
    var rowCount: Int {
        return collection.count
    }
    
    
    // MARK: - Fields
    // MARK: - Functions
    // MARK: - Initializers
    
    init?(_ type: PointViewType, withValues collection: [String]) {
        guard collection.count > 0 else { return nil }
        
        self.type = type
        self.collection = collection
    }
}
