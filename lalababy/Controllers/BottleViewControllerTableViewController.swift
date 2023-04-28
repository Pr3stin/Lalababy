//
//  BottleViewControllerTableViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/23/23.
//

import UIKit
import CoreData

class BottleViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let bottleFeed = BottleFeedings()
    
   
    @IBOutlet weak var typeOfMilk: UISegmentedControl!
    @IBOutlet weak var feedTime: UITextField!
    @IBOutlet weak var amountEaten: UITextField!
    @IBOutlet weak var unitOfMeasurement: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Time Picker
      
        let startTime = UIDatePicker()
        let formatter = DateFormatter()
        let time = Date()
        formatter.dateFormat = "MM/YY hh:mm a"
        startTime.datePickerMode = .time
        startTime.addTarget(self, action: #selector(timePickerValueChanged), for: UIControl.Event.valueChanged)
        startTime.frame.size = CGSize(width: 0, height: 300)
        startTime.preferredDatePickerStyle = .wheels
        feedTime.inputView = startTime
        feedTime.text = formatter.string(from: time)
        
    }
 
    //Saving New Feeding
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let time = feedTime.text,
              let amount = amountEaten.text,
              let type = unitOfMeasurement.titleForSegment(at: unitOfMeasurement.selectedSegmentIndex),
              let typeOf = typeOfMilk.titleForSegment(at: typeOfMilk.selectedSegmentIndex)
        else { return }
        
        
        let newFeeding = BottleFeedings(context: self.context)
        newFeeding.amount = amount
        newFeeding.startTime = time
        newFeeding.amountM = type
        newFeeding.type = typeOf
        
        
        
        self.saveData()
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Error saving Data \(error)")
        }
    }
    
    //Cancel Button
    
    
    @IBAction func cancelBottle(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //Time Picker
    
    @objc func timePickerValueChanged(sender: UIDatePicker) {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/YY hh:mm a"
            feedTime?.text = formatter.string(from: sender.date)
        }
    
    @objc func timeChanged() {
        view.endEditing(true)
    }
    

}
