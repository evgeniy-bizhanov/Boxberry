//
//  UIExtensions.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 05/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

private let UITextFieldIconPadding: CGFloat = 8

@IBDesignable extension UIView {
    
    typealias Value = CGFloat
    typealias Corner = CACornerMask
    
    // MARK: - Radius
    
    /// Радиус скругления `UIView`
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    /// Маска скругления `UIView`
    @IBInspectable var maskedCorners: CGRect {
        get {
            let topLeftCorner = layer.maskedCorners.contains(.layerMinXMinYCorner) ? 1 : 0
            let topRightCorner = layer.maskedCorners.contains(.layerMaxXMinYCorner) ? 1 : 0
            let bottomRightCorner = layer.maskedCorners.contains(.layerMaxXMaxYCorner) ? 1 : 0
            let bottomLeftCorner = layer.maskedCorners.contains(.layerMinXMaxYCorner) ? 1 : 0
            
            let corners = CGRect(
                x: topLeftCorner,
                y: topRightCorner,
                width: bottomRightCorner,
                height: bottomLeftCorner
            )
            
            return corners
            
        }
        set {
            let setupCorner: (Value, Corner) -> Void = { [weak self] value, cornerMask in
                if value > 0 {
                    self?.layer.maskedCorners.insert(cornerMask)
                } else {
                    self?.layer.maskedCorners.remove(cornerMask)
                }
            }
            
            setupCorner(newValue.origin.x, .layerMinXMinYCorner)
            setupCorner(newValue.origin.y, .layerMaxXMinYCorner)
            setupCorner(newValue.size.height, .layerMaxXMaxYCorner)
            setupCorner(newValue.size.width, .layerMinXMaxYCorner)
        }
    }
    
    
    // MARK: - Shadow
    
    /// Цвет тени
    @IBInspectable var shadowColor: UIColor {
        get { return UIColor(cgColor: layer.shadowColor ?? UIColor().cgColor) }
        set { layer.shadowColor = newValue.cgColor }
    }
    
    /// Радиус размытия тени
    @IBInspectable var shadowRadius: CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    /// Прозрачность тени
    @IBInspectable var shadowOpacity: Float {
        get { return layer.shadowOpacity }
        set { layer.shadowOpacity = newValue }
    }
    
    /// Положение тени
    @IBInspectable var shadowOffset: CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }
    
    
    // MARK: - Border
    
    /// Цвет рамки
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor().cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    /// Ширина рамки
    @IBInspectable var borderWidth: Float {
        get { return Float(layer.borderWidth) }
        set { layer.borderWidth = CGFloat(newValue) }
    }
    
    
    // MARK: - Padding
    
    /**
     Отступы содержимого от границ `UIView`
     
     - Attention: Содержимое `UIView` должно быть прилеплено к границам относительно `Margins`
     */
    @IBInspectable var padding: CGRect {
        get {
            let rect = CGRect(
                x: layoutMargins.left,
                y: layoutMargins.top,
                width: layoutMargins.right,
                height: layoutMargins.bottom
            )
            
            return rect
            
        }
        
        set {
            let insets: (top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) = (
                newValue.origin.y,
                newValue.origin.x,
                newValue.size.height,
                newValue.size.width
            )
            
            layoutMargins = UIEdgeInsets(
                top: insets.top,
                left: insets.left,
                bottom: insets.bottom,
                right: insets.right
            )
        }
    }
}

private var storedClearStyle: Bool = false

@IBDesignable extension UITextField {
    
    @IBInspectable var leftImage: UIImage {
        get {
            guard
                let view = leftView?.subviews.first as? UIImageView,
                let image = view.image else {
                    
                    return UIImage()
            }
            
            return image
        }
        
        set {
            let image = UIImageView(image: newValue)
            image.frame.origin.x = UITextFieldIconPadding
            
            var frame = image.frame
            frame.size.width += UITextFieldIconPadding - 1
            
            let view = UIView(frame: frame)
            view.addSubview(image)
            
            leftViewMode = .always
            leftView = view
        }
    }
    
    @IBInspectable var clearStyle: Bool {
        get { return storedClearStyle }
        set {
            
            if newValue {
                borderColor = UIColor.red
                layer.borderColor = UIColor.red.cgColor
                
            }
            
            storedClearStyle = newValue
        }
    }
}

@IBDesignable class UIVibrancyText: UITextField {
    
    @IBInspectable var vibrancy: Bool = false {
        willSet {
            
            let blurEffect = UIBlurEffect(style: .light)
            let vibrancy = UIVibrancyEffect(blurEffect: blurEffect)
            let blurView = UIVisualEffectView(effect: vibrancy)
            //            blurView.frame = bounds
            //            addSubview(blurView)
            
            
            blurView.contentView.addSubview(subviews[1])
            blurView.contentView.addSubview(subviews[0])
            
            
            blurView.frame = bounds
            //            insertSubview(blurView, at: 3)
            
            addSubview(blurView)
        }
    }
}
