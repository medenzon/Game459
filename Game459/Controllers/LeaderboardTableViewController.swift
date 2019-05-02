//
//  LeaderboardTableViewController.swift
//  Game459
//
//  Created by Will Hundahl on 4/30/19.
//  Copyright © 2019 Michael Edenzon. All rights reserved.
//

import UIKit
import CoreData

class LeaderboardTableViewController: UITableViewController {
    
    var results: [Result]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.anthracite
//        self.tableView.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: view.frame.height - 200)
        
        results = loadResults()?.sorted() ?? []
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    private func loadResults() -> [Result]? {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ScoreEntity")
        request.returnsObjectsAsFaults = false
        
        var _results: [Result] = []
        
        do {
            
            let rows = try context.fetch(request) as? [NSManagedObject]
            
            for row in rows! {
                
                let name = row.value(forKey: "name") as? String
                let points = row.value(forKey: "points") as? Int
                let time = row.value(forKey: "time") as? Double
                let score = Score(points: points!, time: time!)
                let result = Result(name: name!, score: score)
                
                _results.append(result)
            }
            
        } catch {
            
            print("Error 1")
            
            return nil
        }
        
        return _results
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)

        cell.textLabel?.text = results[indexPath.row].name
        cell.detailTextLabel?.text = String(results[indexPath.row].score.points)
        cell.backgroundColor = Color.anthracite
        cell.textLabel?.textColor = Color.white
        cell.detailTextLabel?.textColor = Color.yellow

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override var shouldAutorotate: Bool {
        
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return true
    }
}
