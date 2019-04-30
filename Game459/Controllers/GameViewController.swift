//
//  GameViewController.swift
//  Game459
//
//  Created by Michael Edenzon on 2/7/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class GameViewController: ViewController {
    
    var gameView: GameView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gameView = GameView(frame: view.bounds)
        
        view.addSubview(gameView)
    }
}
