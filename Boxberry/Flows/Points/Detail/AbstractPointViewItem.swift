//
//  AbstractPointViewItem.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 05/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

protocol AbstractPointViewItem {
    var type: PointViewType { get }
    var rowCount: Int { get }
    var label: String { get }
    var collection: [String] { get }
}

extension AbstractPointViewItem {
    var rowCount: Int { return 1 }
    var label: String { return type.rawValue }
}
