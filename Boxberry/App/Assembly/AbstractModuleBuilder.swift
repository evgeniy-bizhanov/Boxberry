//
//  AbstractModuleBuilder.swift
//  TOGO
//
//  Created by Евгений Бижанов on 31/10/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import Swinject

// Экземпляр сборщика DI-контейнера, доступен только из текущего файла
fileprivate let assembler = Assembler(
    [
        EnvironmentAssembler(),
        NetworkAssembler(),
        PointsAssembler()
    ]
)

/**
 Абстрактная фабрика объектов
 */
public class AbstractModuleBuilder: NSObject {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        resolve(resolver: assembler.resolver)
    }
    
    /// Разрешает зависимости
    /// - Parameter resolver: Контейнер зависимостей, который выполняет разрешение зависимостей
    open func resolve(resolver: Resolver) {}
}
