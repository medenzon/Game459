//
//  Block.swift
//  Game459
//
//  Created by Michael Edenzon on 2/5/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class Block: UIView {
    
    public var highlighted = false
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.layer.borderWidth = 2
        self.layer.borderColor = Color.white.cgColor
        self.backgroundColor = Color.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
