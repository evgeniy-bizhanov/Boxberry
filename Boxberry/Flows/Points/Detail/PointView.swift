//
//  Point.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 28/12/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import UIKit

class PointView: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var prepaidImage: UIImageView!
    @IBOutlet weak var deliveryImage: UIImageView!
    
    
    // MARK: - Models
    
    var model: PointViewModel? {
        didSet {
            modelDidLoad(with: model)
        }
    }
    
    
    // MARK: - Services
    // MARK: - Properties
    
    var finishFlow: (() -> Void)?
    
    
    // MARK: - Fields
    
    // MARK: - IBActions
    
    @IBAction func closeAction(_ sender: Any) {
        finishFlow?()
    }
    
    
    // MARK: - Functions
    
    func modelDidLoad(with value: PointViewModel?) {
        
        guard let value = value else { return }
        
        addressLabel.reactive.text <~ value.address
        cardImage.reactive.isHidden <~ value.card.map { !$0 }
        deliveryImage.reactive.isHidden <~ value.delivery.map { !$0 }
        prepaidImage.reactive.isHidden <~ value.prepaid.map { !$0 }
    }
    
    
    // MARK: - Initializers
}
