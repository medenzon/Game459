//
//  Score.swift
//  Game459
//
//  Created by Michael Edenzon on 5/1/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

struct Score {
    
    var points: Int
    var time: TimeInterval
    
    init(points: Int, time: TimeInterval) {
        self.points = points
        self.time = time
    }
}
