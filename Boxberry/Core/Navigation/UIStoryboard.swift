//
//  UIStoryboard.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 26/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension UIViewController: Identifiable { }

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    
    func instantiateViewController<T: UIViewController>(_: T.Type) -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("View controller с идентификатором \(T.identifier) не найден")
        }
        
        return viewController
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("View controller с идентификатором \(T.identifier) не найден")
        }
        
        return viewController
    }
}
