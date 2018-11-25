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
        
        container.register(​AbstractErrorParser​.self) { _ in
            ErrorParser()
        }
        
        container.register(DispatchQueue.self) { _ in
            DispatchQueue.global(qos: .userInteractive)
        }
    }
}
