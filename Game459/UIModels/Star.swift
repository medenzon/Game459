//
//  Star.swift
//  Game459
//
//  Created by Michael Edenzon on 4/26/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class Star: UIImageView {
    
    static let id = 0
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        get {
            return .ellipse
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.image = UIImage(named: "star.pdf")
        self.tag = Star.id
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
