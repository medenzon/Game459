//
//  MapMakerViewController.swift
//  Game459
//
//  Created by Michael Edenzon on 3/11/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit
import CoreData

enum MapLoadingError: Error {
    case unableToQuery
}

class MapMakerViewController: ViewController {
    
    var maps: [[[Int8]]] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
}
