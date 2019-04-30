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
    var fallingBehavior: GravityBehavior!
    var collision: CollisionBehavior!
    var collectionBehavior: CollectionBehavior!
    var avatarBehavior: AvatarBehavior!
    var blockBehavior: BlockBehavior!
    var motionManager: CMMotionManager!
    var scoreboard: UILabel!
    var gameOver = false
    var score = 0
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = Color.anthracite
        
        addMapView()        //  1
        createAvatar()      //  2
        createBlocks()      //  3
        createStars()       //  4
        addBehaviors()      //  5
        addAnimator()       //  6
        setupMotion()       //  7
        updateMotion()      //  8
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
        
        for star in Elements.stars {
            fallingBehavior.addItem(star)
        }
        
        self.addSubview(mapView)
    }
    
    ///
    /// Build and place a UILabel below the MapView as the game's scoreboard
    ///
    func addScoreboard() {
        
        scoreboard = UILabel(frame: CGRect(x: 0, y: frame.height - 100, width: frame.width, height: 48))
        scoreboard.adjustsFontSizeToFitWidth = true
        scoreboard.textAlignment = .center
        scoreboard.textColor = Color.white
        scoreboard.text = String(score)
        self.addSubview(scoreboard)
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
    /// Registers the MapView's stars with the game's elements manager.
    ///
    func createStars() {
        
        Elements.stars.append(contentsOf: mapView.stars)
    }
    
    ///
    /// Initializes UIDynamics behaviors and registers them with the
    /// game's elements manager.
    ///
    func addBehaviors() {
        
        gravity = GravityBehavior(items: Elements.avatars)
        Behaviors.add(gravity)
        fallingBehavior = GravityBehavior()
        fallingBehavior.gravityDirection = CGVector(dx: 0, dy: -1)
        collision = CollisionBehavior(items: Elements.items, delegate: self)
        collectionBehavior = CollectionBehavior(items: Elements.stars + Elements.avatars, delegate: self)
        collision.addChildBehavior(collectionBehavior)
        avatarBehavior = AvatarBehavior(items: Elements.avatars)
        blockBehavior = BlockBehavior(items: Elements.blocks)
    }
    
    ///
    /// Initializes a custom UIDynamicAnimator with the behaviors
    /// initialized in addBehaviors().
    ///
    func addAnimator() {
        
        animator = Animator(referenceView: self, behaviors: Behaviors.all)
    }
    
    ///
    /// Initialized the CoreMotion motion manager, and sets accelerometer
    /// updates to an one-one thousandth of a second.
    ///
    func setupMotion() {
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        motionManager.accelerometerUpdateInterval = 0.0001
    }
    
    ///
    /// Updates the game's assets base on device's environmental information.
    /// 1. Acceleration values are received as (*x*, *y*)
    /// 2. The gravity's direction is set as (*x*, -*y*)
    /// 3. Each item assigned a gravity behavior is updated with the new
    ///    gravity direction.
    ///
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

                let offsetY = self.mapView.frame.origin.y
                var avatarCenter = self.gravity.items.first!.center
                avatarCenter.y = avatarCenter.y - offsetY
                
                if self.gameOver {
                    
                } else {
                    
                    self.collision(at: avatarCenter)
                    
                    if self.score >= self.mapView.map.zeroCount {
                        
                        self.gameOver = true
                    }
                }

                self.animator.addBehavior(self.gravity)
            }
        }
    }
    
    func collision(at point: CGPoint) {
        
        let location = mapView.coordinates(of: point)
        let value = mapView.map.value(at: location)
        var item: UIView?
        
        if value == 0 {
            mapView.cover(location)
            mapView.map.set(location, to: -1)
            score += 1
            scoreboard.text = String(score)
            mapView.cover(location)
        }
        
        if (location.row >= 0 && location.row < mapView.items.count) &&
            (location.col >= 0 && location.col < mapView.items[0].count) {
            
            item = mapView.items[location.row][location.col]
            
            UIView.animate(withDuration: 2.5) {
                item?.transform = CGAffineTransform(translationX: 0, y: 1000)

            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
