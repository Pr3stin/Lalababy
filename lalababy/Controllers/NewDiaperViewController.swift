//
//  NewDiaperViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/24/23.
//

import UIKit
import CoreData

class NewDiaperViewController: UIViewController {

    @IBOutlet weak var diaperPicker: UISegmentedControl!
    @IBOutlet weak var timeChanged: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let diaperChange = Diapers()
    
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
        timeChanged.inputView = startTime
        timeChanged.text = formatter.string(from: time)
     
    }
    
    //Save
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let diaper = diaperPicker.titleForSegment(at: diaperPicker.selectedSegmentIndex),
              let timePick = timeChanged.text
        else { return}
        
        let newDiaper = Diapers(context: self.context)
        newDiaper.time = timePick
        newDiaper.diaperType = diaper
        
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
    
    //Cancel
    
    @IBAction func cancelDiaper(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //Time Picker
    
    @objc func timePickerValueChanged(sender: UIDatePicker) {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/YY hh:mm a"
            timeChanged?.text =  formatter.string(from: sender.date)
        timeChanging()
        }
    
    @objc func timeChanging() {
        view.endEditing(true)
    }
   

}
