//
//  FirstLaunch.swift
//  Game459
//
//  Created by Michael Edenzon on 4/7/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import Foundation

final class FirstLaunch {
    
    let userDefaults: UserDefaults = .standard
    let wasLaunchedBefore: Bool
    
    var isFirstLaunch: Bool {
        
        return !wasLaunchedBefore
    }
    
    init() {
        
        let key = "com.any-suggestion.FirstLaunch.WasLaunchedBefore"
        let wasLaunchedBefore = userDefaults.bool(forKey: key)
        
        self.wasLaunchedBefore = wasLaunchedBefore
        
        if !wasLaunchedBefore {
            userDefaults.set(true, forKey: key)
        }
    }
    
}
