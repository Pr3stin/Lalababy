//
//  DiaperViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/24/23.
//

import UIKit
import CoreData

class DiaperViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var itemArray = [Diapers]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    //Load Data
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }

    //Cells

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaperLogCell", for: indexPath)
        let diaper = itemArray[indexPath.row]
        cell.textLabel?.text = "\(diaper.time ?? "") Status:  \(diaper.diaperType ?? "")"
        return cell
    }
    
    func loadData() {
        let request : NSFetchRequest<Diapers> = Diapers.fetchRequest()
        
        do {
            itemArray = try context.fetch(request)
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
            context.delete(itemArray[indexPath.row])
            itemArray.remove(at: indexPath.row)
            do { try context.save()
            } catch {
                print("error deleting item")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
