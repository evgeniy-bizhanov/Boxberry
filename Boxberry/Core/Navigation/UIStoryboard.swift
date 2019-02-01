//
//  UIStoryboard.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 26/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /// Instantiate the new instance of `ViewController` by its type identifier
    func instantiateViewController<T: UIViewController>(_: T.Type) -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("View controller с идентификатором \(T.identifier) не найден")
        }
        
        return viewController
    }
    
    /// Instantiate the new instance of `ViewController` by its type identifier
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("View controller с идентификатором \(T.identifier) не найден")
        }
        
        return viewController
    }
}
