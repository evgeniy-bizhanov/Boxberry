//
//  UITableView.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 07/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

// https://stackoverrun.com/ru/q/3845036#41688467

// MARK: - Dequeuing

extension UITableView {
    
    typealias Transform<T> = (T?) -> Void
    
    // FIXME: Need to be resolved throuthout inheritance, cause of applies absolutely to all instance in current time
    override open var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: self.contentSize.height)
    }
    
    /// Gets a reusable cell out of the queue or register new one
    /// Can transform cell throught closure before return
    ///
    /// - Parameter identifier: A string identifying the cell object to be reused. This parameter must not be nil
    /// - Parameter indexPath: The index path specifying the location of the cell
    /// - Parameter nibName: A string identifying the nib cell. if this parameter is nil, it equated to identifier
    /// - Parameter transform: Transformation closure based on generic parameter
    func dequeueReusableCell<T>(
        withIdentifier identifier: String, for indexPath: IndexPath, fromNib nibName: String? = nil,
        transformWith transform: Transform<T>?) -> UITableViewCell {
        
        let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath, fromNib: nibName)
        transform?(cell as? T)
        
        return cell
    }
}


// MARK: - Fileprivate

extension UITableView {
    
    fileprivate func registerReusableCell(
        withIdentifier identifier: String, for indexPath: IndexPath, fromNib nibName: String?) -> UITableViewCell {
        
        let nibName = nibName ?? identifier
        let nib = UINib(nibName: nibName, bundle: nil)
        
        register(nib, forCellReuseIdentifier: identifier)
        
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    fileprivate func dequeueReusableCell(
        withIdentifier identifier: String, for indexPath: IndexPath, fromNib nibName: String?) -> UITableViewCell {
        
        return
            dequeueReusableCell(withIdentifier: identifier) ??
                registerReusableCell(withIdentifier: identifier, for: indexPath, fromNib: nibName)
    }
}
