//
//  AvatarBehavior.swift
//  Game459
//
//  Created by Michael Edenzon on 3/30/17.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class AvatarBehavior: UIDynamicItemBehavior {
    
    override init(items: [UIDynamicItem]) {
        
        super.init(items: items)
        
        self.elasticity = 0.05
        self.friction = 0.5
        self.density = 5
        self.allowsRotation = true
        
        Behaviors.add(self)
    }
}
