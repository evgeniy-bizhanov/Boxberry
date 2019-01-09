//
//  ContactView.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 06/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Bond
import UIKit

class ContactView: UITableViewCell, UITableViewItem {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var value: UIButton!
    
    
    // MARK: - Properties
    
    var item = Observable<String?>(nil)
    var isLabelHidden = Observable<Bool>(true)
    
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        value.reactive.title <~ item
        label.reactive.isHidden <~ isLabelHidden
    }
}
