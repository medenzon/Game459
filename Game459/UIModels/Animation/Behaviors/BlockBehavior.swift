//
//  BlockBehavior.swift
//  Game459
//
//  Created by Michael Edenzon on 3/30/17.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class BlockBehavior: UIDynamicItemBehavior {
    
    override init(items: [UIDynamicItem]) {
        
        super.init(items: items)
        
        self.elasticity = 0.0
        self.friction = 0.0
        self.density = 0.7
        self.allowsRotation = true
        self.isAnchored = true
        
        Behaviors.add(self)
    }
}
