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
        
        container.register(AbstractDeepLinkManager.self) { resolver in
            guard let errorParser = resolver.resolve(AbstractErrorParser.self) else {
                fatalError(
                    "Can't resolve \(AbstractDeepLinkManager.self) cause of " +
                    "\(AbstractErrorParser.self) could not be resolved")
            }
            
            return DeepLinkManager(errorParser: errorParser)
        }
        
        // Презентер
        container.register(PointViewInput.self) { _, output in
            return PointViewPresenter(output: output)
        }
    }
}
