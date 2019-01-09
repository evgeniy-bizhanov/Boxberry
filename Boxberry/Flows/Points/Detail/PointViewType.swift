//
//  PointViewType.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 05/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

enum PointViewType: String {
    case schedule = "Schedule"
    case contact = "Contact"
    case metro = "Metro"
}

protocol PointViewTypeProtocol {}

extension Identifiable where Self: PointViewTypeProtocol {
    var identifier: String {
        return String(describing: self).capitalized + "View"
    }
}

extension PointViewType: Identifiable, PointViewTypeProtocol {}
