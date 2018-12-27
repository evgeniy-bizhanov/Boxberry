//
//  UIViewController.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 27/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChild(viewController controller: UIViewController, embedIn view: UIView? = nil) {
        
        guard let view = view ?? self.view else {
            fatalError("Контейнер для контроллера не определен")
        }
        
        addChild(controller)
        view.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            controller.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
        
        controller.didMove(toParent: self)
    }
}
