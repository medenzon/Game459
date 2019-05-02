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
    
    var controller: GameViewController!
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
    
    var time = 0
    var timerLabel: UILabel!
    var countdownTimer: Timer!
    var totalTime = 60
    
    
    init(frame: CGRect, controller: GameViewController) {
        
        super.init(frame: frame)
        
        self.controller = controller
        self.backgroundColor = Color.anthracite
        
        addMapView()        //  1
        addScoreboard()     //  2
        
        addTimer()          //  3
        startTimer()
        
        createAvatar()      //  4
        createBlocks()      //  5
        createStars()       //  6
        addBehaviors()      //  7
        addAnimator()       //  8
        setupMotion()       //  9
        updateMotion()      //  10
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
    /// Build and place a UILabel below the MapView as the game's Timer
    ///
    func addTimer() {
        
        timerLabel = UILabel(frame: CGRect(x: 0, y: frame.height - 52, width: frame.width, height: 48))
        timerLabel.adjustsFontSizeToFitWidth = true
        timerLabel.textAlignment = .center
        timerLabel.textColor = Color.white
        timerLabel.text = String(time)
        self.addSubview(timerLabel)
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
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
        
        let top = Block(frame: CGRect(x: 0, y: mapView.frame.origin.y - mapView.size, width: frame.width, height: mapView.size))
        let bottom = Block(frame: CGRect(x: 0, y: mapView.frame.origin.y + mapView.frame.height, width: frame.width, height: mapView.size))
        
        addSubview(top)
        addSubview(bottom)
        
        self.sendSubviewToBack(top)
        self.sendSubviewToBack(bottom)
        
        Elements.blocks.append(contentsOf: [top, bottom])
        Elements.items.append(contentsOf: [top, bottom])
        
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
                
                if self.gameOver || self.totalTime == 0 {
                    
                    self.motionManager.stopAccelerometerUpdates()
                    self.endTimer()
                    self.controller.gameEnded(with: Score(points: self.score, time: 10))
                    
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

///
/// Code for detecting collisions and animating a star collection.
///
extension GameView {
    
    private func collision(at point: CGPoint) {
        
        let location = mapView.coordinates(of: point)
        let value = mapView.map.value(at: location)
        
        if value == 0 {
            
            mapView.map.set(location, to: -1)
            
            score += 1
            scoreboard.text = String(score)
            
            if (location.row >= 0 && location.row < mapView.items.count) &&
                (location.col >= 0 && location.col < mapView.items[0].count) {
                
                let star = mapView.items[location.row][location.col]
                
                beginCollectionAnimation(for: star)
            }
        }
    }
    
    private func beginCollectionAnimation(for item: UIView) {
        
        mapView.bringSubviewToFront(item)
        
        let offsetY = self.mapView.frame.origin.y
        let dy = item.frame.origin.y + offsetY
        let duration = Double((1 - (dy / frame.height)) * 10)
        
        item.alpha = 0.5
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.25, options: .curveEaseOut, animations: {
            
            let rot = self.rotationDirection()
            
            let randC = CGFloat(Double.random(in: 0.7 ..< 1) * 20) * rot
            let randD = CGFloat((Double.random(in: 0.7 ..< 1) * 20)) * (rot * -1)
            
            item.transform = CGAffineTransform(a: 2, b: 2, c: randC, d: randD, tx: 0, ty: (dy * -1) - 400)
            
        }) { (true) in
            
            item.removeFromSuperview()
        }
    }
    
    private func rotationDirection() -> CGFloat {
        
        var n: Int!
        let rand = Int.random(in: 0..<2)
        
        if rand == 1 {
            
            n = 1
            
        } else {
            
            n = -1
        }
        
        return CGFloat(n)
    }
}
