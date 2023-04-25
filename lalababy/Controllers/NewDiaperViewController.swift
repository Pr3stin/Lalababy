//
//  NewDiaperViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/24/23.
//

import UIKit

class NewDiaperViewController: UIViewController {

    @IBOutlet weak var wetButton: UIButton!
    @IBOutlet weak var dirtyButton: UIButton!
    @IBOutlet weak var dryButton: UIButton!
    @IBOutlet weak var timeChanged: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Button Picker
        
        dryButton?.layer.masksToBounds = true
        dryButton?.layer.cornerRadius = 5
        wetButton?.layer.masksToBounds = true
        wetButton?.layer.cornerRadius = 5
        dirtyButton?.layer.masksToBounds = true
        dirtyButton?.layer.cornerRadius = 5
        dryButton.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
                view.addSubview(dryButton)
        wetButton.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
                view.addSubview(wetButton)
        dirtyButton.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
                view.addSubview(dirtyButton)
        
        //Time Picker
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        formatter.string(from: time)
        timeChanged?.text = "Time: " + formatter.string(from: time)
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 200)
        timeChanged?.inputView = timePicker
        timePicker.addTarget(self, action: #selector(timeChanging), for: .valueChanged)
     
    }
    
    //Cancel
    
    @IBAction func cancelDiaper(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //Button Selected
    
    @objc func buttonSelected(_ sender: UIButton){
        if sender == dryButton {
            dryButton.backgroundColor = UIColor.white
            wetButton.backgroundColor = UIColor(named: "BackgroundBlue")
            dirtyButton.backgroundColor = UIColor(named: "BackgroundBlue")
        } else if sender == wetButton {
            wetButton.backgroundColor = UIColor.white
            dryButton.backgroundColor = UIColor(named: "BackgroundBlue")
            dirtyButton.backgroundColor = UIColor(named: "BackgroundBlue")
        } else if sender == dirtyButton {
            dirtyButton.backgroundColor = UIColor.white
            wetButton.backgroundColor = UIColor(named: "BackgroundBlue")
            dryButton.backgroundColor = UIColor(named: "BackgroundBlue")
        }
    }
    
    //Time Picker
    
    @objc func timePickerValueChanged(sender: UIDatePicker) {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm"
            timeChanged?.text = "Start Time: " + formatter.string(from: sender.date)
        }
    
    @objc func timeChanging() {
        view.endEditing(true)
    }
   

}
