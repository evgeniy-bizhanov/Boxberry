//
//  Identifable.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 09/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

/// Supply type identifier based on its name
protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    
    /// Type identifier
    static var identifier: String {
        return String(describing: self)
    }
}
