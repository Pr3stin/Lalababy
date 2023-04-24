//
//  BreastFeedingController.swift
//  lalababy
//
//  Created by Prestin Lau on 4/22/23.
//

import UIKit

class BreastFeedingController: UIViewController {
    
    @IBOutlet weak var timerLabel1: UILabel!
    @IBOutlet weak var timerLabel2: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var totalTimeLabel: UILabel!

    var timerL: Timer?
    var timerR: Timer?
    var startTimeL: Date?
    var startTimeR: Date?
    var elapsedTimeL: TimeInterval = 0
    var elapsedTimeR: TimeInterval = 0
    var isRunningR: Bool = false
    var isRunningL: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Time Picker
        
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        formatter.string(from: time)
        startTime?.text = "Start Time: " + formatter.string(from: time)
        
        
        
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        timePicker.frame.size = CGSize(width: 0, height: 200)
        startTime?.inputView = timePicker
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        
        //Total Time Label
        totalTimeLabel?.layer.masksToBounds = true
        totalTimeLabel?.layer.cornerRadius = 5
        
        
    }
    
    // Time Picker
   
    @objc func timePickerValueChanged(sender: UIDatePicker) {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm"
            startTime?.text = "Start Time: " + formatter.string(from: sender.date)
        }
    
    @objc func timeChanged() {
        view.endEditing(true)
    }
    
    
    // Left and Right Timers
    
    @IBAction func leftButtonPressed(_ sender: Any) {
        
        if isRunningL {
            timerL?.invalidate()
            timerL = nil
            elapsedTimeL += Date().timeIntervalSince(startTimeL!)
            isRunningL = false
        } else {
            startTimeL = Date()
            timerL = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.elapsedTimeL = Date().timeIntervalSince(self.startTimeL!)
                self.updateLeftTimerLabel()
            }
            isRunningL = true
        }
        
        if timerL == nil {
               timerL = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
                   guard let self = self else { return }
                   self.elapsedTimeL += 1
                   self.totalTime(withTimerElapsedR: self.elapsedTimeR, elapsedTimerL: self.elapsedTimeL)
               })
           } else {
               timerL?.invalidate()
               timerL = nil
           }
    }
    
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        
        if isRunningR {
            timerR?.invalidate()
            timerR = nil
            elapsedTimeR += Date().timeIntervalSince(startTimeR!)
            isRunningR = false
        } else {
            startTimeR = Date()
            timerR = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.elapsedTimeR = Date().timeIntervalSince(self.startTimeR!)
                self.updateRightTimerLabel()
            }
            isRunningR = true
        }
        
        if timerR == nil {
                timerR = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
                    guard let self = self else { return }
                    self.elapsedTimeR += 1
                    self.totalTime(withTimerElapsedR: self.elapsedTimeR, elapsedTimerL: self.elapsedTimeL)
                })
            } else {
                timerR?.invalidate()
                timerR = nil
            }
    }
    
    
    func updateRightTimerLabel() {
               let minutes = Int(elapsedTimeR / 60)
               let seconds = Int(elapsedTimeR) % 60
               timerLabel2?.text = String(format: "%02d:%02d", minutes, seconds)
           }
        
        func updateLeftTimerLabel() {
               let minutes = Int(elapsedTimeL / 60)
               let seconds = Int(elapsedTimeL) % 60
            timerLabel1?.text = String(format: "%02d:%02d", minutes, seconds)
           }
    
    func totalTime(withTimerElapsedR elapsedTimerR: TimeInterval, elapsedTimerL: TimeInterval) {
        let totalTimeElapsed = elapsedTimeL + elapsedTimeR
        
        let minutes = Int(totalTimeElapsed) / 60 % 60
        let seconds = Int(totalTimeElapsed) % 60
        
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        
        totalTimeLabel?.text = "Total Time: " + timeString
    }
    
}

      
    

