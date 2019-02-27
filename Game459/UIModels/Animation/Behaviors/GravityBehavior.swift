//
//  GravityBehavior.swift
//  Game459
//
//  Created by Michael Edenzon on 3/30/17.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class GravityBehavior: UIGravityBehavior {
    override init(items: [UIDynamicItem]) {
        super.init(items: items)
        
        Behaviors.add(behavior: self)
    }
}
