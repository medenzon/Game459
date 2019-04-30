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

class Data {
    
    
    public static func save(entityName: String, value: [[Int8]], key: String) {
        
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
    
    
    public static func getMaps() /*throws -> Void*/ {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: COREDATA_MAPENTITY_NAME)
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request) as? [NSManagedObject]
            
            for result in results! {
                
                let matrix = result.value(forKey: "matrix") as? String
                
                print(matrix!)
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
    
    public static func createMaps() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let mapEntity = NSEntityDescription.entity(forEntityName: "MapEntity", in: managedContext)
        
        for i in 0..<GAME_MATRIX_SET.count {
            
            let matrix = GAME_MATRIX_SET[i]
            let map = NSManagedObject(entity: mapEntity!, insertInto: managedContext)
            
            map.setValue(Map(matrix: matrix).description, forKey: "matrix")
            map.setValue(i, forKey: "number")
        }
        
        do {
            
            try managedContext.save()
            
        } catch let error as NSError {
            
            print("Error: Unable to save.")
            print("\(error), \(error.userInfo)")
        }
        
        
    }
    
    
    func retrieveData() {
        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
//        let managedContext = appDelegate?.persistentContainer.viewContexts
    }
}
