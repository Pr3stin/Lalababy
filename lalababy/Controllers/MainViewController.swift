//
//  ViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/10/23.
//

import UIKit
import CoreData

class MainViewController: UITableViewController {

    
    @IBOutlet var Feedings: UITableView!
    
    let itemArray = ["Hello", "Brother"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedingLogCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

   
    

}

