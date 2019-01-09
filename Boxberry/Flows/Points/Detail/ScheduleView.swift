//
//  ScheduleView.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 06/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import Bond
import UIKit

class ScheduleView: UITableViewCell, PointViewCellModel {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    
    // MARK: - Properties
    
    var title = Observable<String?>(nil)
    var value = Observable<String?>(nil)
    var titleIsHidden = Observable<Bool>(true)
    
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        valueLabel.reactive.text <~ value
        titleLabel.reactive.isHidden <~ titleIsHidden
    }
}
