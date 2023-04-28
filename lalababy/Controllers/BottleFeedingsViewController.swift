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
        //let bottle = BottleFeedingss()
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottleCell", for: indexPath)
        let bottle = array[indexPath.row]
       cell.textLabel?.text = "\(bottle.startTime ?? "")   \(bottle.type ?? "")  \(bottle.amount ?? "") \(bottle.amountM ?? "")"
        
                return cell
    }
    
    
  
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving Data \(error)")
        }
        tableView.reloadData()
    }
    
    func loadData() {
        let request : NSFetchRequest<BottleFeedings> = BottleFeedings.fetchRequest()
        
        do {
            array = try context.fetch(request)
        } catch {
            print("Error loading Data \(error)")
        }
        tableView.reloadData()
    }
    
}

