//
//  EnvironmentAssembler.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 25/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Swinject

class EnvironmentAssembler: Assembly {
    
    func assemble(container: Container) {
        
        container.register(AbstractErrorParser.self) { _ in
            ErrorParser()
        }
        
        container.register(DispatchQueue.self) { _ in
            DispatchQueue.global(qos: .userInteractive)
        }
        
        container.register(AbstractExternalsManager.self) { resolver in
            guard let errorParser = resolver.resolve(AbstractErrorParser.self) else {
                fatalError(
                    "Can't resolve \(AbstractExternalsManager.self) cause of " +
                    "\(AbstractErrorParser.self) could not be resolved")
            }
            
            return ExternalsManager(errorParser: errorParser)
        }.inObjectScope(.container)
    }
}
