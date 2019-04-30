//
//  MapView.swift
//  Game459
//
//  Created by Michael Edenzon on 2/7/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class MapView: UIView {
    
    var map: Map!
    var size: CGFloat!
    var blocks: [Block] = []
    var stars: [Star] = []
    var items: [[UIView]] = []

    init(frame: CGRect, map: Map) {
        
        super.init(frame: frame)
        
        self.map = map
        self.size = frame.width / CGFloat(map.cols)
        self.backgroundColor = Color.anthracite
        
        build()
    }
    
    ///
    /// Calculates the rown and column of a given point. This is used to map
    /// a points x and y values to a specific index in the game's matrix
    ///
    /// - Parameters:
    ///   - point: A given point in a view. The point passed in should
    ///            be offset as necessary to match the bounds of MapView.
    /// - Returns:
    ///   - The Location (row and column) of a given point.
    ///
    func coordinates(of point: CGPoint) -> Location {
        
        let col = Int(floor(point.x / (frame.width/CGFloat(map.cols))))
        let row = Int(floor(point.y / (frame.height/CGFloat(map.rows))))
        
        return Location(row, col)
    }
    
    ///
    /// Determines the origin point in a view from the given location's row
    /// and column. This is done by multiplying the location's row and column
    /// values individually by the determined block size.
    ///
    /// - Parameters:
    ///   - location: A row and column value.
    /// - Returns:
    ///   - The row and column's point
    ///
    func origin(of location: Location) -> CGPoint {
        
        let x = CGFloat(location.col) * size
        let y = CGFloat(location.row) * size
        
        return CGPoint(x: x, y: y)
    }
    
    ///
    /// Builds and displays the game's graphical map based on the map's
    /// representational matrix.
    ///
    func build() {
        
        for row in 0..<map.rows {
            
            for col in 0..<map.cols {
                
                let location = Location(row, col)
                let origin = self.origin(of: location)
                let size = CGSize(width: self.size, height: self.size)
                
                var rowItems: [UIView] = []

                if map.value(at: location) == 1 {
                    
                    let block = Block(frame: CGRect(origin: origin, size: size))
                    
                    blocks.append(block)
                    self.addSubview(block)
                    rowItems.append(block)
                    
                } else if map.value(at: location) == 0 {
                    
                    let star = Star(frame: CGRect(origin: origin, size: size))
                    
                    stars.append(star)
                    self.addSubview(star)
                    rowItems.append(star)
                }
            }
        }
    }
    
    func cover(_ location: Location) {
        
        let origin = self.origin(of: location)
        let size = CGSize(width: self.size, height: self.size)
        let block = Block(frame: CGRect(origin: origin, size: size))
        
        block.layer.borderWidth = 0
        block.backgroundColor = Color.anthracite
        
        self.addSubview(block)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
