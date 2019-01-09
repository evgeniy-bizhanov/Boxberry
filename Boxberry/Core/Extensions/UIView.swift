//
//  UIView.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 04/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

extension UIView: Identifiable {}

@IBDesignable class UIXibView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        loadFromNib { [weak self]result in
            switch result {
            case .error(let error):
                fatalError(error)
            case .value(let view):
                self?.didLoadFromNib(view)
            }
        }
    }
}

fileprivate extension UIView {

    typealias Completion = (Result<UIView>) -> Void
    
    fileprivate func didLoadFromNib(_ view: UIView) {
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        addSubview(view)
    }
    
    func loadFromNib(_ completion: Completion?) {
        let typeOfSelf = type(of: self)
        let nib = UINib(nibName: typeOfSelf.identifier, bundle: nil)
        
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            completion?(.value(view))
        } else {
            completion?(.error("View с идентификатором \(typeOfSelf.identifier) не найден"))
        }
    }
}
