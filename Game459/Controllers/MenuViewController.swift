//
//  MenuViewController.swift
//  Game459
//
//  Created by Michael Edenzon on 2/7/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class MenuViewController: ViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = Color.anthracite
        
//        let frame = CGRect(x: 0, y: -200, width: view.frame.width, height: view.frame.height + 200)
//        
//        let starsView = StarsView(frame: frame, points: 25)
//        
//        view.addSubview(starsView)
//        view.sendSubviewToBack(starsView)
    }
    
    override var shouldAutorotate: Bool {
        
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return true
    }
}
