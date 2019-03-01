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

    init(frame: CGRect, map: Map) {
        
        super.init(frame: frame)
        
        self.map = map
        self.size = frame.width / CGFloat(map.cols)
        self.backgroundColor = Color.skyblue
        
        build()
    }
    
    ///
    /// Calculates the rown and column of a given point. This is used to map
    /// a points x and y values to a specific index in the game's matrix
    ///
    /// - Parameters:
    ///   - point: A given point in a view.
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
                
                if map.value(at: location) == 1 {
                    
                    let origin = self.origin(of: location)
                    let size = CGSize(width: self.size, height: self.size)
                    let box = Block(frame: CGRect(origin: origin, size: size))
                    
                    blocks.append(box)
                    self.addSubview(box)
                }
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
