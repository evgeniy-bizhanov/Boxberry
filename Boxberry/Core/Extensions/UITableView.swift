//
//  UITableView.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 07/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

// https://stackoverrun.com/ru/q/3845036#41688467

fileprivate var UITableViewIsStaticHeight: Bool = false

extension UITableView {
    
    typealias Transform<T> = (T?) -> Void
    
    override open var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: self.contentSize.height)
    }
    
    fileprivate func registerReusableCell(withIdentifier identifier: String, fromNib nibName: String?) {
        let nibName = nibName ?? identifier
        let nib = UINib(nibName: nibName, bundle: nil)
        
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    fileprivate func dequeueReusableCell(
        withIdentifier identifier: String, for indexPath: IndexPath, fromNib nibName: String?) -> UITableViewCell {
        
        if let cell = dequeueReusableCell(withIdentifier: identifier) {
            return cell
        } else {
            registerReusableCell(withIdentifier: identifier, fromNib: nibName)
            return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    func dequeueReusableCell<T>(
        withIdentifier identifier: String, for indexPath: IndexPath, fromNib nibName: String? = nil,
        transformWith transform: Transform<T>?) -> UITableViewCell {
        
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath, fromNib: nibName)
        transform?(cell as? T)
        
        return cell
    }
}
