//
//  DataLoad.swift
//  Game459
//
//  Created by Michael Edenzon on 7/1/18.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit
import CoreData

let COREDATA_MAPENTITY_NAME = "MapEntity"

class Load {
    
    init() {
        for matrix in GAME_MATRIX_SET {
            save(entityName: COREDATA_MAPENTITY_NAME, value: matrix, key: "matrix")
        }
    }
    
    private func save(entityName: String, value: [[Int8]], key: String) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let newCollection = NSManagedObject(entity: entity!, insertInto: context)
        
        newCollection.setValue(value, forKey: key)
        do {
            try context.save()
        } catch {
            print("Save attempt unsuccessful.")
            return
        }
    }
}
