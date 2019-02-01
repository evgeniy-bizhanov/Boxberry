//
//  PointsViewBuilder.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 20/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Swinject

class PointViewBuilder: AbstractModuleBuilder {
    
    @IBOutlet weak var vc: PointViewController!
    
    override func resolve(resolver: Resolver) {
        let input = resolver.resolve(PointViewInput.self, argument: vc as PointViewOutput)
        vc.input = input
    }
}
