//
//  DeepLinkManager.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 10/01/2019.
//  Copyright © 2019 Евгений Бижанов. All rights reserved.
//

import UIKit

class DeepLinkManager: AbstractDeepLinkManager {
    
    // MARK: - Properties
    
    let errorParser: AbstractErrorParser
    
    
    // MARK: - Initializers
    
    init(errorParser: AbstractErrorParser) {
        self.errorParser = errorParser
    }
}

protocol AbstractDeepLinkManager {
    
    func callPhoneNumber(_ phoneNumber: String, completion: ((Result<Bool>) -> Void)?)
}

extension AbstractDeepLinkManager {
    
    func callPhoneNumber(_ phoneNumber: String, completion: ((Result<Bool>) -> Void)?) {
        
        guard
            let url = URL(string: "tel://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
                
                completion?(.error("Can't call phone number '\(phoneNumber)'"))
                return
        }
        
        UIApplication.shared.open(url, options: [:]) { result in
            completion?(.success(result))
        }
    }
}
