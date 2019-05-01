//
//  GameViewController.swift
//  Game459
//
//  Created by Michael Edenzon on 2/7/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit
import CoreData

class GameViewController: ViewController {
    
    var gameView: GameView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gameView = GameView(frame: view.bounds, controller: self)
        
        view.addSubview(gameView)
    }
    
    func save(name: String, score: Score) -> Bool {
        
        var didSave = false
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let scoreEntity = NSEntityDescription.entity(forEntityName: "ScoreEntity", in: managedContext)
        let scoreObject = NSManagedObject(entity: scoreEntity!, insertInto: managedContext)
        
        scoreObject.setValue(name, forKey: "name")
        scoreObject.setValue(score.points, forKey: "points")
        scoreObject.setValue(Double(score.time), forKey: "time")
        
        do {
            
            try managedContext.save()
            
            didSave = true
            
        } catch let error as NSError {
            
            print("Error: Unable to save.")
            print("\(error), \(error.userInfo)")
        }
        
        return didSave
    }
    
    func gameEnded(with score: Score) {
        
        var didSave = false
        
        let alert = UIAlertController(title: "Game Over", message: "Your score is \(score.points). Please enter your name.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter name..."
        }
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
//            let textField = alert?.textFields![0]
//            print("Text field: \(String(describing: textField!.text))")
            self.save(name: alert!.textFields![0].text!, score: score)
            self.performSegue(withIdentifier: "gameOverLeaderboard", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    override var shouldAutorotate: Bool {
        
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return true
    }
}
