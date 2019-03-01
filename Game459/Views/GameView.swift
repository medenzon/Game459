//
//  GameView.swift
//  Game459
//
//  Created by Michael Edenzon on 2/7/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit
import CoreMotion

class GameView: UIView, UICollisionBehaviorDelegate {
    
    var mapView: MapView!
    var animator: Animator!
    var gravity: GravityBehavior!
    var collision: CollisionBehavior!
    var avatarBehavior: AvatarBehavior!
    var blockBehavior: BlockBehavior!
    var motionManager: CMMotionManager!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Color.skyblue
        
        addMapView()
        createAvatar()
        createBlocks()
        addBehaviors()
        addAnimator()
        setupMotion()
        updateMotion()
    }
    
    ///
    /// Initializes a MapView and positions it in the vertical and
    /// horizontal center of the game view.
    ///
    func addMapView() {
        
        let origin = CGPoint(x: 0, y: 0)
        let m = min(self.frame.width, self.frame.height)
        let size = CGSize(width: m, height: m)
        let frame = CGRect(origin: origin, size: size)
        
        mapView = MapView(frame: frame, map: Map(matrix: GAME_MATRIX))
        
        let dy = (self.frame.height - mapView.frame.height) / 2
        
        mapView.transform = CGAffineTransform(translationX: 0, y: dy)
        
        self.addSubview(mapView)
    }
    
    ///
    /// Initializes an Ellipse type as the game's avatar, places it at
    /// the starting point, and registers it with the games elements manager
    ///
    func createAvatar() {
        
        let x = mapView.frame.origin.x + 1
        let y = mapView.frame.origin.y + 1
        let width = mapView.size * 0.75
        let height = mapView.size * 0.75
        let frame = CGRect(x: x, y: y, width: width, height: height)
        
        let ellipse = Ellipse(frame: frame, color: Color.red)
        
        self.addSubview(ellipse)
        
        Elements.avatars.append(ellipse)
        Elements.items.append(ellipse)
    }
    
    ///
    /// Registers the MapView's blocks with the game's elements manager.
    ///
    func createBlocks() {
        
        Elements.blocks.append(contentsOf: mapView.blocks)
        Elements.items.append(contentsOf: mapView.blocks)
    }
    
    ///
    /// Initializes UIDynamics behaviors and registers them with the
    /// game's elements manager.
    ///
    func addBehaviors() {
        
        gravity = GravityBehavior(items: Elements.avatars)
        collision = CollisionBehavior(items: Elements.items, delegate: self)
        avatarBehavior = AvatarBehavior(items: Elements.avatars)
        blockBehavior = BlockBehavior(items: Elements.blocks)
    }
    
    func addAnimator() {
        
        animator = Animator(referenceView: self, behaviors: Behaviors.all)
    }
    
    func setupMotion() {
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.001
    }
    
    func updateMotion() {
        
        self.motionManager.startAccelerometerUpdates(to: OperationQueue()) {
            
            (data, error) in
            
            DispatchQueue.main.async {
                
                let accelerometerData = self.motionManager.accelerometerData
                let dx = accelerometerData!.acceleration.x
                let dy = accelerometerData!.acceleration.y
                
                self.animator.removeBehavior(self.gravity)
                self.gravity.gravityDirection = CGVector(dx: dx, dy: dy * -1)
                
                for item in self.gravity.items {
                    self.animator.updateItem(usingCurrentState: item)
                }
                
                self.animator.addBehavior(self.gravity)
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
