//
//  UIViewController.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 27/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

// MARK: - Identifiable
extension UIViewController: Identifiable { }


// MARK: - Embedding

extension UIViewController {
    
    /// Embed source `ViewController` in destination `ViewController`
    ///
    /// - Parameter view: A view that needs to embed source view
    /// - Parameter destination: `ViewController` in whose view is needs to embed source view
    func embedIn(_ view: UIView? = nil, of destination: UIViewController) {
        
        guard let view = view ?? destination.view else {
            fatalError("Контейнер для контроллера не определен")
        }
        
        defer {
            self.didMove(toParent: destination)
        }
        
        destination.addChild(self)
        view.addSubview(self.view)
        layoutConstraints(self.view, toView: view)
    }
    
    /// Embed source `ViewController` in destination `ViewController` from nib (xib file)
    ///
    /// - Parameter container: A view that needs to embed source view
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
    
    /// Dismiss the embedded `ViewController`
    func dismissFromParent() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
