//
//  PointViewType.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 05/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

/// Types of content for point detail controller
enum PointViewType: String {
    case schedule = "Schedule"
    case contact = "Contact"
    case metro = "Metro"
}

/// Protocol intendent for hacking enum based Self constraint to give it identifier
protocol PointViewTypeProtocol {}

extension Identifiable where Self: PointViewTypeProtocol {
    var identifier: String {
        return String(describing: self).capitalized + "View"
    }
}

extension PointViewType: Identifiable, PointViewTypeProtocol {}
