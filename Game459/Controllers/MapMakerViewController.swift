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
        let load = Load()
        loadMaps()
        super.viewDidLoad()
    }
    
    private func loadMaps() /*throws -> Void*/ {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: COREDATA_MAPENTITY_NAME)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request) as? [NSManagedObject]
            for result in results! {
                let matrix = result.value(forKey: "matrix") as? String
                print(matrix)
            }
        } catch {
            print("Error 1")
            return
        }
        
//
//        if !(maps.count <= 0) {
//            throw MapLoadingError.unableToQuery
//        }
    }
}
