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
    
    typealias Completion<T> = (T?) -> T?
    
    override open var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: self.contentSize.height)
    }
    
    func dequeueReusableCell<T>(
        _ type: T.Type,
        withIdentifier identifier: String,
        for indexPath: IndexPath, fromNib nibName: String? = nil,
        completion: Completion<T>?) -> UITableViewCell {
        
        if let cell = self.dequeueReusableCell(withIdentifier: identifier) {
            return completion?(cell as? T) as? UITableViewCell ?? cell
        }
        
        let nibName = nibName ?? identifier
        let nib = UINib(nibName: nibName, bundle: nil)
        
        self.register(nib, forCellReuseIdentifier: identifier)
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        return completion?(cell as? T) as? UITableViewCell ?? cell
    }
}
