//
//  Mappable.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 02/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Foundation

/// Экземпляры протокола могут быть сконвертированы друг в друга
public protocol Mappable: Encodable {
    /// Выполняет мэппинг свойств одного типа на другой
    func map<TDestination: Decodable>() throws -> TDestination
}

extension Mappable {
    public func map<TDestination: Decodable>() throws -> TDestination {
        let sourcePropertyListEncoded = try PropertyListEncoder().encode(self)
        return try PropertyListDecoder().decode(TDestination.self, from: sourcePropertyListEncoded)
    }
}
