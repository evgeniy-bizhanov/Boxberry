//
//  MapViewDelegate.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 17/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import YandexMapKit

protocol MapViewDelegate: class {
    
    func cameraPositionDidChanged()
    func azimuthDidChanged()
}
