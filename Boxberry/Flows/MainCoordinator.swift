//
//  MainCoordinator.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 26/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

fileprivate let storyboardId = "Points"

final class MainCoordinator: AbstractCoordinator {
    
    var rootController: UINavigationController?
    var detailController: UIViewController?
    
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showMainModule()
    }
    
    private func showMainModule() {
        
        let controller = UIStoryboard(name: storyboardId, bundle: nil)
            .instantiateViewController(PointsViewController.self)
        
        controller.onDetailRequest = { [weak self] container, point in
            self?.showDetailModule(embedIn: container, destination: controller)
        }
        
        let rootController = UINavigationController(rootViewController: controller)
        setAsRoot(rootController)
        
        self.rootController = rootController
    }
    
    private func showDetailModule(embedIn view: UIView, destination: UIViewController) {
        
        guard detailController == nil else {
            return
        }
        
        let controller = UIStoryboard(name: storyboardId, bundle: nil)
            .instantiateViewController(PointViewController.self)
        
        destination.addChild(viewController: controller, embedIn: view)
        
        self.detailController = controller
    }
}
