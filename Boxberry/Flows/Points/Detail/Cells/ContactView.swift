//
//  ContactView.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 06/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Bond
import UIKit

class ContactView: UITableViewCell, PointViewCellModel, ContactCellModel {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueButton: UIButton!
    
    
    // MARK: - Properties
    
    var title = Observable<String?>(nil)
    var value = Observable<String?>(nil)
    var titleIsHidden = Observable<Bool>(true)
    
    var onContactTap: ContactTap?
    
    
    // MARK: - IBActions
    
    @IBAction func didTapValueButton(_ sender: Any) {
        onContactTap?(value.value)
    }
    
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        valueButton.reactive.title <~ value.map { $0?.asFormatPhoneNumber }
        titleLabel.reactive.isHidden <~ titleIsHidden
    }
}
