//
//  CollectionBehavior.swift
//  Game459
//
//  Created by Michael Edenzon on 4/26/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class CollectionBehavior: UICollisionBehavior {
    
    override init(items: [UIDynamicItem]) {
        
        super.init(items: items)
    }
    
    init(items: [UIDynamicItem], delegate: UICollisionBehaviorDelegate) {
        
        super.init(items: items)
        
        self.collisionDelegate = delegate
        self.collisionMode = .items
        
//        Behaviors.add(self)
    }
}

