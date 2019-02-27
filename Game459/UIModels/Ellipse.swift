//
//  Ellipse.swift
//  Game459
//
//  Created by Michael Edenzon on 4/19/16.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class Ellipse: UIView {
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        get {
            return .ellipse
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame)
        self.backgroundColor = color
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
