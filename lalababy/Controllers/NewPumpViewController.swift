//
//  NewPumpViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/24/23.
//

import UIKit

class NewPumpViewController: UIViewController {

   
    @IBOutlet weak var amountPumped: UITextField!
    @IBOutlet weak var measurementPicker: UISegmentedControl!
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = Timer()
    var isTimerRunning = false
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Time Picker
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        formatter.string(from: time)
        timeText?.text = "Start Time: " + formatter.string(from: time)
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 200)
        timeText?.inputView = timePicker
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
        //Amount Pumped
        
        amountPumped.placeholder = "Amount Pumped:"
        amountPumped.keyboardType = .decimalPad
        
        //Timer
        
        timerButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
      
    
    }
    
    //Cancel
    
    
    @IBAction func cancelNewPump(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Timer
    
    @objc func startTimer() {
          if isTimerRunning {
              timer.invalidate()
              timerButton.setTitle("Resume", for: .normal)
          } else {
              timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
              timerButton.setTitle("Pause", for: .normal)
          }
          isTimerRunning = !isTimerRunning
      }

      @objc func updateTimer() {
          counter += 1
          let minutes = String(format: "%02d", counter / 60)
          let seconds = String(format: "%02d", counter % 60)
          timeLabel.text = "\(minutes):\(seconds)"
      }
    
    
    //Time Picker
    
    @objc func timePickerValueChanged(sender: UIDatePicker) {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm"
            timeText?.text = "Start Time: " + formatter.string(from: sender.date)
        }
    
    @objc func timeChanged() {
        view.endEditing(true)
    }
    

}
