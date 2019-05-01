//
//  StarsView.swift
//  Game459
//
//  Created by Michael Edenzon on 5/1/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class StarsView: UIView, UICollisionBehaviorDelegate {
    
    var gravity: GravityBehavior!
    var collision: CollisionBehavior!
    var avatarBehavior: AvatarBehavior!
    var blockBehavior: BlockBehavior!
    var animator: Animator!
    var stars: [Star] = []

    init(frame: CGRect, points: Int) {
        
        super.init(frame: frame)
        
        self.backgroundColor = Color.anthracite
        
        let count = 6
        var blocks: [Block] = []
        
        for i in 1..<count {
            
            let origin = CGPoint(x: (CGFloat(i)/CGFloat(count)) * frame.width, y: 125)
            let size = CGSize(width: 15, height: 15)
            let block = Block(frame: CGRect(origin: origin, size: size))
            block.transform = CGAffineTransform(rotationAngle: 45)
            
            self.addSubview(block)
            blocks.append(block)
        }
        
        gravity = GravityBehavior(items: [])
        collision = CollisionBehavior(items: blocks, delegate: self)
        avatarBehavior = AvatarBehavior(items: [])
        blockBehavior = BlockBehavior(items: blocks)
        
        self.animator = Animator(referenceView: self)
        self.animator.add([gravity,collision, avatarBehavior, blockBehavior])
        
        
        for _ in 0..<points {
            
            let origin = CGPoint(x: CGFloat.random(in: 0..<frame.width), y: CGFloat.random(in: 0..<50))
            let rand = CGFloat.random(in: 10..<50)
            let size = CGSize(width: rand, height: rand)
            let star = Star(frame: CGRect(origin: origin, size: size))
            
            star.image = UIImage(named: "star-big.pdf")
            
            stars.append(star)
            
            self.addSubview(star)
            
            self.gravity.addItem(star)
            self.collision.addItem(star)
            self.avatarBehavior.addItem(star)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
