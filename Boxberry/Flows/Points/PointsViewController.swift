//
//  PointsViewController.swift
//  Boxberry
//
//  Created by Евгений Бижанов on 18/11/2018.
//  Copyright © 2018 Евгений Бижанов. All rights reserved.
//

import CoreLocation
import UIKit
import YandexMapKit

protocol PointsViewOutput {
    
    func didFetch(userLocation location: CLLocation)
}

class PointsViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet var mapView: YMKMapView!
    
    
    // MARK: - Models
    // MARK: - Services
    // MARK: - Properties
    // MARK: - Fields
    // MARK: - IBActions
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Initializers
    
}

extension PointsViewController: PointsViewOutput {
    func didFetch(userLocation location: CLLocation) {
        print("fetched user location \(location.coordinate)")
    }
}
