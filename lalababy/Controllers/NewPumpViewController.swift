//
//  NewPumpViewController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/24/23.
//

import UIKit
import CoreData

class NewPumpViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let newPump = Pumps()
   
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
        
        let startTime = UIDatePicker()
        let formatter = DateFormatter()
        let time = Date()
        formatter.dateFormat = "MM/YY hh:mm a"
        startTime.datePickerMode = .time
        startTime.addTarget(self, action: #selector(timePickerValueChanged), for: UIControl.Event.valueChanged)
        startTime.frame.size = CGSize(width: 0, height: 300)
        startTime.preferredDatePickerStyle = .wheels
        timeText.inputView = startTime
        timeText.text = formatter.string(from: time)
        
        //Timer
        
        timerButton.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
      
    
    }
    
    //Save
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let timer = timeLabel.text,
              let time = timeText.text,
              let amount = amountPumped.text,
              let measurement = measurementPicker.titleForSegment(at: measurementPicker.selectedSegmentIndex)
        else { return }
        
        let newPump = Pumps(context: self.context)
        newPump.startTime = time
        newPump.amountM = measurement
        newPump.timer = timer
        newPump.totalAmount = amount
        
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
            formatter.dateFormat = "MM/YY hh:mm a"
            timeText?.text =  formatter.string(from: sender.date)
             timeChanged()
        }
    
    @objc func timeChanged() {
        view.endEditing(true)
    }
    

}
