//
//  BreastViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/26/23.
//

import UIKit
import CoreData

class BreastViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var breastFeeding = [BreastFeedings]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return breastFeeding.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreastCell", for: indexPath)
        let breast = breastFeeding[indexPath.section]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.text = "\(breast.startTime ?? "") L: \(breast.left ?? "") R: \(breast.right ?? "")      \(breast.totalTime ?? "")"
        return cell
    }

    
    func loadData() {
        let request : NSFetchRequest<BreastFeedings> = BreastFeedings.fetchRequest()
        
        do {
            breastFeeding = try context.fetch(request)
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
            context.delete(breastFeeding[indexPath.section])
            breastFeeding.remove(at: indexPath.section)
            do { try context.save()
            } catch {
                print("error deleting item")
            }
            tableView.deleteSections([indexPath.section], with: .fade)
        }
    }

}
