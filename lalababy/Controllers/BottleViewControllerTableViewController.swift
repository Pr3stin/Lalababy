//
//  BottleViewControllerTableViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/23/23.
//

import UIKit

class BottleViewController: UIViewController {

    
    @IBOutlet weak var formulaButton: UIButton!
    @IBOutlet weak var milkButton: UIButton!
    @IBOutlet weak var feedTime: UITextField!
    @IBOutlet weak var amountEaten: UITextField!
    @IBOutlet weak var unitOfMeasurement: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Button Picker
        
        formulaButton?.layer.masksToBounds = true
        formulaButton?.layer.cornerRadius = 5
        milkButton?.layer.masksToBounds = true
        milkButton?.layer.cornerRadius = 5
        formulaButton.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
                view.addSubview(formulaButton)
        milkButton.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
                view.addSubview(milkButton)
        
        
        //Time Picker
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        formatter.string(from: time)
        feedTime?.text = "Time: " + formatter.string(from: time)
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 200)
        feedTime?.inputView = timePicker
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
        //Amount Eaten
        
        amountEaten.placeholder = "Amount Eaten:"
        amountEaten.keyboardType = .decimalPad
        
        
        
    }
 
    @IBAction func saveButtonPressed(_ sender: Any) {
        print("save tapped")
    }
    
    //Cancel Button
    
    
    @IBAction func cancelBottle(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Button Picker
    
    @objc func buttonSelected(_ sender: UIButton){
        if sender == formulaButton {
            formulaButton.backgroundColor = UIColor.white
            milkButton.backgroundColor = UIColor(named: "BackgroundBlue")
        } else if sender == milkButton {
            milkButton.backgroundColor = UIColor.white
            formulaButton.backgroundColor = UIColor(named: "BackgroundBlue")
        }
    }
    
    //Time Picker
    
    @objc func timePickerValueChanged(sender: UIDatePicker) {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm"
            feedTime?.text = "Start Time: " + formatter.string(from: sender.date)
        }
    
    @objc func timeChanged() {
        view.endEditing(true)
    }

}
