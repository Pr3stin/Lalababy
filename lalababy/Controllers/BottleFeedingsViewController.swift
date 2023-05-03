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
    
    //Load Data
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BottleCell", for: indexPath)
        let bottle = array[indexPath.section]
       cell.textLabel?.text = "\(bottle.startTime ?? "")  \(bottle.type ?? "") - \(bottle.amount ?? "") \(bottle.amountM ?? "")"
        
                return cell
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
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(array[indexPath.section])
            array.remove(at: indexPath.section)
            do { try context.save()
            } catch {
                print("error deleting item")
            }
            tableView.deleteSections([indexPath.section], with: .fade)
        }
    }
    
}

