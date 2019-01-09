//
//  PointViewController.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 06/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

// MARK: - UIViewController

class PointViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var prepaidImage: UIImageView!
    @IBOutlet weak var deliveryImage: UIImageView!
    
    
    // MARK: - Models
    
    var model: PointViewModel?
    
    
    // MARK: - Services
    // MARK: - Properties
    
    var onClose: (() -> Void)?
    
    
    // MARK: - Fields
    // MARK: - IBActions
    
    @IBAction func closeAction(_ sender: Any) {
        onClose?()
    }
    
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        setupTable(model)
        setupBindings(model)
    }
    
    func setupTable(_ model: PointViewModel?) {
        guard let model = model else {
            return
        }
        
        tableView.dataSource = model
    }
    
    func setupBindings(_ model: PointViewModel?) {
        guard let model = model else {
            return
        }
        
        titleLabel.reactive.text <~ model.address
        cardImage.reactive.isHidden <~ model.card.map { !$0 }
        prepaidImage.reactive.isHidden <~ model.prepaid.map { !$0 }
        deliveryImage.reactive.isHidden <~ model.delivery.map { !$0 }
    }
    
    
    // MARK: - Initializers
}


// MARK: - UITableViewDelegate

extension PointViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard 0..<tableView.numberOfSections - 1 ~= section else { return 0 }
        return 1
    }
}
