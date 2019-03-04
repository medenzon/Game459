//
//  Animator.swift
//  Game459
//
//  Created by Michael Edenzon on 3/30/17.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class Animator: UIDynamicAnimator {
    
    override init(referenceView view: UIView) {
        
        super.init(referenceView: view)
    }
    
    convenience init(referenceView view: UIView, behaviors: [UIDynamicBehavior]) {
        
        self.init(referenceView: view)
        
        add(behaviors)
    }
    
    ///
    /// Adds behaviors to the animator.
    ///
    /// - Parameters:
    ///   - behaviors: An array of behaviors.
    ///
    func add(_ behaviors: [UIDynamicBehavior]) {
        
        for behavior in behaviors {
            
            self.addBehavior(behavior)
        }
    }
}
