//
//  BreastFeedingController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/22/23.
//

import UIKit
import CoreData

class BreastFeedingController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let breastFeed = BreastFeedings()
    
    @IBOutlet weak var timerLabel1: UILabel!
    @IBOutlet weak var timerLabel2: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var totalTimeLabel: UILabel!

    var timerL = Timer()
    var timerR = Timer()
    var counterL = 0
    var counterR = 0
    var isTimerRunningR = false
    var isTimerRunningL = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Timers
        
        rightButton?.addTarget(self, action: #selector(startTimerR), for: .touchUpInside)
        
        leftButton?.addTarget(self, action: #selector(startTimerL), for: .touchUpInside)
        
        
        // Time Picker
        
        let pickTime = UIDatePicker()
        let formatter = DateFormatter()
        let time = Date()
        formatter.dateFormat = "MM/YY hh:mm a"
        pickTime.datePickerMode = .time
        pickTime.addTarget(self, action: #selector(timePickerValueChanged), for: UIControl.Event.valueChanged)
        pickTime.frame.size = CGSize(width: 0, height: 300)
        pickTime.preferredDatePickerStyle = .wheels
        startTime.inputView = pickTime
        startTime.text = formatter.string(from: time)
        
        //Total Time Label
        totalTimeLabel?.layer.masksToBounds = true
        totalTimeLabel?.layer.cornerRadius = 5
        
        
    }
    
    //Save Button Pressed
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let leftV = timerLabel1.text,
              let rightV = timerLabel2.text,
              let startTimeV = startTime.text,
              let totalTimeV = totalTimeLabel.text
        else { return }
        
        let newFeeding = BreastFeedings(context: self.context)
        newFeeding.left = leftV
        newFeeding.right = rightV
        newFeeding.startTime = startTimeV
        newFeeding.totalTime = totalTimeV
        
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
    
    //Breast Feed Cancel
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Time Picker
    
    @objc func timePickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/YY hh:mm"
        startTime?.text = "Start Time: " + formatter.string(from: sender.date)
        timeChanged()
    }
    
    @objc func timeChanged() {
        view.endEditing(true)
    }
    
    
    // Left and Right Timers
    
    @objc func startTimerL() {
        if isTimerRunningL {
            timerL.invalidate()
            leftButton.setTitle("Resume", for: .normal)
        } else {
            timerL = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateLeftTimerLabel), userInfo: nil, repeats: true)
            leftButton.setTitle("Pause", for: .normal)
        }
        isTimerRunningL = !isTimerRunningL
    }
    
    @objc func startTimerR() {
        if isTimerRunningR {
            timerR.invalidate()
            rightButton.setTitle("Resume", for: .normal)
        } else {
            timerR = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateRightTimerLabel), userInfo: nil, repeats: true)
            rightButton.setTitle("Pause", for: .normal)
        }
        isTimerRunningR = !isTimerRunningR
    }
    
    
    
   
    
    
    @objc func updateRightTimerLabel() {
        
        counterR += 1
        let minutes = String(format: "%02d", counterR / 60)
        let seconds = String(format: "%02d", counterR % 60)
        timerLabel2.text = "\(minutes):\(seconds)"
        updateTotalTime()
    }
    
    @objc func updateLeftTimerLabel() {
        
        counterL += 1
        let minutes = String(format: "%02d", counterL / 60)
        let seconds = String(format: "%02d", counterL % 60)
        timerLabel1.text = "\(minutes):\(seconds)"
        updateTotalTime()
    }
    
    
    @objc func updateTotalTime() {
        let totalSeconds = counterR + counterL
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        totalTimeLabel.text = String(format: "Total: %02d:%02d", minutes, seconds)
    }
    
}

      
    

