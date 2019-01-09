//
//  PointViewCell.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 09/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Bond

protocol PointViewCellModel: class {
    var title: Observable<String?> { get }
    var value: Observable<String?> { get }
    var titleIsHidden: Observable<Bool> { get }
}
