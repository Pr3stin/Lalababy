//
//  ViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/10/23.
//

import UIKit
import CoreData

class MainViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
    var array = [BottleFeedings]()
    
    
    
    @IBOutlet var Feedings: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bottle = BottleFeedings()
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottleCell", for: indexPath)
        let item = array[indexPath.row]
        cell.textLabel?.text = " \(bottle.type ?? "") \(bottle.startTime ?? "") \(bottle.amount ?? "") \(bottle.amountMeasurement ?? "")"
                return cell
    }
    
}

