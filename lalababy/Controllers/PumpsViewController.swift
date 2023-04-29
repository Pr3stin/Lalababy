//
//  PumpsViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/24/23.
//

import UIKit
import CoreData

class PumpsViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var itemArray = [Pumps]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    //Load Data
    
    func loadData() {
        let request : NSFetchRequest<Pumps> = Pumps.fetchRequest()
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error loading Data \(error)")
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    //Cells

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PumpingLogCell", for: indexPath)
        let pumper = itemArray[indexPath.row]
        cell.textLabel?.text = "\(pumper.startTime ?? "") For: \(pumper.timer ?? "") \(pumper.totalAmount ?? "") \(pumper.amountM ?? "")"
        return cell
    }
    

}
