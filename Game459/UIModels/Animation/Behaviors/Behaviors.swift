//
//  Behaviors.swift
//  Game459
//
//  Created by Michael Edenzon on 3/30/17.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

struct Behaviors {
    
    static private var behaviors: [UIDynamicBehavior] = []
    
    static var all: [UIDynamicBehavior] {
        get {
            return self.behaviors
        }
    }
    
    static func add(behavior: UIDynamicBehavior) {
        behaviors.append(behavior)
    }
}
