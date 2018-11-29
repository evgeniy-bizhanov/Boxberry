//
//  PointRequestProtocol.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 24/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

protocol PointRequestProtocol: AbstractRequestManager {
    
    /**
     Получает список точек выдачи заказов
     - Parameter prepaid: Позволяет получить в выборке в том числе и отделения, работающие с предоплаченными посылками
     - Parameter city: Код города, для которого необходимо получить список отеделений
     */
    func listPoints(
        prepaid: Bool,
        city: Int,
        completion: @escaping Completion<[Point]>
    )

    /**
     Получает список точек выдачи заказов
     - Parameter prepaid: Позволяет получить в выборке в том числе и отделения, работающие с предоплаченными посылками
     */
    func listPoints(
        prepaid: Bool,
        completion: @escaping Completion<[Point]>
    )

    /**
     Получает список точек выдачи заказов
     - Parameter city: Код города, для которого необходимо получить список отеделений
     */
    func listPoints(
        city: Int,
        completion: @escaping Completion<[Point]>
    )

    /**
     Получает список точек выдачи заказов
     */
    func listPoints(
        completion: @escaping Completion<[Point]>
    )
}
