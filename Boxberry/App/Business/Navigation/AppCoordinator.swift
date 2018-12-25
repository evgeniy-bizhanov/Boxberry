//
//  AppCoordinator.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 25/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

final class AppCoordinator: AbstractCoordinator {
    
    override func start() {
        toMain()
    }
    
    private func toMain() {
        
        let coordinator = MainCoordinator()
        
        coordinator.onFinishFlow = { [weak self] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        
        addDependency(coordinator)
        coordinator.start()
    }
}
