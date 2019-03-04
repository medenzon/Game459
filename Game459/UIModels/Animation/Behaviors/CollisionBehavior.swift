//
//  CollisionBehavior.swift
//  Game459
//
//  Created by Michael Edenzon on 3/30/17.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class CollisionBehavior: UICollisionBehavior {
    
    override init(items: [UIDynamicItem]) {
        
        super.init(items: items)
        
        self.translatesReferenceBoundsIntoBoundary = true
    }
    
    init(items: [UIDynamicItem], delegate: UICollisionBehaviorDelegate) {
        
        super.init(items: items)
        
        self.collisionDelegate = delegate
        self.translatesReferenceBoundsIntoBoundary = true
        
        Behaviors.add(self)
    }
}
