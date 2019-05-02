//
//  Result.swift
//  Game459
//
//  Created by Michael Edenzon on 5/1/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

struct Result {
    
    var name: String
    var score: Score
    
    public var description: String {
        return "\(name)\t \t|\t \(score.points) \t|\t \(score.time)"
    }
    
    init(name: String, score: Score) {
        self.name = name
        self.score = score
    }
}

extension Result: Equatable {
    
    static func == (lhs: Result, rhs:  Result) -> Bool {
        
        return lhs.score.points == rhs.score.points
    }
}

extension Result: Comparable {
    
    static func < (lhs: Result, rhs: Result) -> Bool {
        
        if lhs.score.points > rhs.score.points {
            
            return lhs.score.points > rhs.score.points
            
        } else {
            
            return lhs.score.points < rhs.score.points
        }
    }
}
