//
//  TimerViewController.swift
//  Game459
//
//  Created by Will Hundahl on 5/1/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    import UIKit
    
    class ViewController: UIViewController {
        
        @IBOutlet weak var timerLabel: UILabel!
        
       
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
        }
        
       
        
        @IBAction func startTimerPressed(_ sender: UIButton) {
            startTimer()
        }
        
}
