//
//  UIViewController.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 27/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func embedIn(_ view: UIView, of controller: UIViewController) {
        
        controller.addChild(self)
        view.addSubview(self.view)
        layoutConstraints(self.view, toView: view)
        
        self.didMove(toParent: controller)
    }
    
    @discardableResult
    func loadFromNib<T: UIViewController>(_: T.Type, to container: UIView?) -> T {
        
        guard let container = container ?? self.view else {
            fatalError("Контейнер для контроллера не определен")
        }
        
        let controller = T(nibName: T.identifier, bundle: nil)
        
        self.addChild(controller)
        
        container.addSubview(controller.view)
        layoutConstraints(controller.view, toView: container)
        
        controller.didMove(toParent: self)
        
        return controller
    }
    
    fileprivate func layoutConstraints(_ view: UIView, toView container: UIView) {
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            view.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0)
            ])
    }
    
    func dismissFromParent() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
