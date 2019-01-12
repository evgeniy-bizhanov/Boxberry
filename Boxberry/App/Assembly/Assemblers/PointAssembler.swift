//
//  PointsAssembler.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 20/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Swinject

class PointAssembler: Assembly {
    
    func assemble(container: Container) {
        
        // Презентер
        container.register(PointViewInput.self) { resolver, output in
            return PointViewPresenter(
                output: output,
                externals: resolver.resolve(AbstractExternalsManager.self)
            )
        }
    }
}
