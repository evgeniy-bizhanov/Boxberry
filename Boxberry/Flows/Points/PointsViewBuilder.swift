//
//  PointsViewBuilder.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 20/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Swinject

class PointsViewBuilder: AbstractModuleBuilder {
    
    @IBOutlet weak var vc: PointsViewController!
    
    override func resolve(resolver: Resolver) {
        let input = resolver.resolve(PointsViewInput.self, argument: vc as PointsViewOutput)
        vc.input = input
    }
}
