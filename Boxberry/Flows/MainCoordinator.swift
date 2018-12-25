//
//  MainCoordinator.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 26/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

final class MainCoordinator: AbstractCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showMainModule()
    }
    
    private func showMainModule() {
        
        let controller = UIStoryboard(name: "Points", bundle: nil)
            .instantiateViewController(PointsViewController.self)
        
        controller.onDetailRequest = { point in
            // TODO: Сделать переход на контроллер детальной информации
        }
        
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        
        self.rootController = rootController
    }
}
