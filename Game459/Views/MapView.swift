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
    
    func coordinates(of point: CGPoint) -> Location {
        
        let col = Int(floor(point.x / (frame.width/CGFloat(map.cols))))
        let row = Int(floor(point.y / (frame.height/CGFloat(map.rows))))
        
        return Location(row, col)
    }
    
    func origin(of location: Location) -> CGPoint {
        
        let x = CGFloat(location.col) * size
        let y = CGFloat(location.row) * size
        
        return CGPoint(x: x, y: y)
    }
    
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
