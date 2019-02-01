//
//  AbstractCoordinator.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 25/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

class AbstractCoordinator {

    var childCoordinators: [AbstractCoordinator] = []

    func start() {}

    func addDependency(_ coordinator: AbstractCoordinator) {
        
        for element in childCoordinators where element === coordinator {
            return
        }
        
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: AbstractCoordinator) {
        
        guard childCoordinators.isEmpty == false else { return }

        for (index, element) in childCoordinators.reversed().enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    func setAsRoot(_ controller: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
}
