//
//  DiaperViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/24/23.
//

import UIKit

class DiaperViewController: UITableViewController {

    let itemArray = ["Test Cell 1", "Test Cell 2", "Test Cell 3", "Test Cell 4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    //Cells

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaperLogCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

}
