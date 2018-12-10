//
//  UIButton.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 09/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

extension UIButton {
    static func circleButton(forImage image: UIImage? = nil, radius: CGFloat) -> UIButton {
        
        let button = UIButton(type: .custom)
        
        button.backgroundColor = UIColor(hex: 0xFFFFFF, alpha: 0.9)
        
        button.cornerRadius = radius
        
        button.shadowColor = .black
        button.shadowRadius = 5
        button.shadowOpacity = 0.2
        button.shadowOffset = CGSize(width: 0, height: 1)
        
        button.isHidden = true
        
        if let image = image {
            button.setImage(image, for: .normal)
        }
        
        button.widthAnchor.constraint(equalToConstant: 2 * radius).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        
        return button
    }
}
