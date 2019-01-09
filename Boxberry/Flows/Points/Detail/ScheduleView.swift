//
//  ScheduleView.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 06/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Bond
import UIKit

class ScheduleView: UITableViewCell, UITableViewItem {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var value: UILabel!
    
    
    // MARK: - Properties
    
    var item = Observable<String?>(nil)
    var isLabelHidden = Observable<Bool>(true)
    
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        value.reactive.text <~ item
        label.reactive.isHidden <~ isLabelHidden
    }
}
