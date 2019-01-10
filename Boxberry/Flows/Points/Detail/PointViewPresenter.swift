//
//  PointViewPresenter.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 10/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

protocol PointViewInput: ViewInput {
    var model: PointViewModel? { get set }
}

class PointViewPresenter: NSObject, PointViewInput {
    
    // MARK: - IBOutlets
    // MARK: - Models
    // MARK: - Services
    
    var externals: AbstractExternalsManager?
    
    
    // MARK: - Properties
    
    var model: PointViewModel?
    
    
    // MARK: - Fields
    
    private weak var output: PointViewOutput!
    
    
    // MARK: - IBActions
    // MARK: - Functions
    
    func call(to phoneNumber: String?) {
        guard let phoneNumber = phoneNumber else {
            // TODO: Show alert message
            return
        }
        
        externals?.callPhoneNumber(phoneNumber, completion: nil)
    }
    
    
    // MARK: - Initializers
    
    init(output: PointViewOutput, externals: AbstractExternalsManager?) {
        self.output = output
        self.externals = externals
    }
}


// MARK: - UITableViewDataSource

extension PointViewPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.items[section].rowCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let items = model?.items else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.section]
        let identifier = item.type.identifier
        
        return tableView
            .dequeueReusableCell(withIdentifier: identifier, for: indexPath) { (cell: PointViewCellModel?) in
                guard let cell = cell else {
                    return
                }
                
                if indexPath.row == 0 {
                    cell.titleIsHidden.value = false
                }
                
                cell.title.value = item.label
                cell.value.value = item.collection[indexPath.row]
                
                if let cell = cell as? ContactCellModel {
                    cell.onContactTap = { [weak self] contact in
                        self?.call(to: contact)
                    }
                }
            }
    }
}
