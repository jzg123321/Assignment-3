//
//  ViewController.swift
//  Assignment003
//
//  Created by Josh Guiang on 6/12/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var count : Int = 0
    var timer = Timer()
    var timer2 = Timer()
    var totalSeconds : TimeInterval?
    var player : AVAudioPlayer!
    
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var timerValue: UIDatePicker!
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var currentTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonOne.setTitle("Start Timer", for: .normal)
        remainingTimeLabel.text = ""
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.displayCurrentTime()
        })
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if (buttonOne.currentTitle == "Stop Music"){
            player.stop()
            buttonOne.setTitle("Start Timer", for: .normal)
        } else {
            timer2.invalidate()
            totalSeconds = timerValue.countDownDuration
            timer2 = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSeconds), userInfo: nil, repeats: true)
        }
    }
    
    func displayCurrentTime() {
        let currentDate = Date()
        let format = DateFormatter()
        format.dateFormat = "EEE, dd MMM yyyy HH:mm:ss"
        currentTime.text = format.string(from: currentDate)
        let currentHour = currentTime.text!.suffix(8)
        if (Int(currentHour.prefix(2))! >= 12) {
            backgroundImage.image = UIImage(named: "Morning")
        } else {
            backgroundImage.image = UIImage(named: "Night")
        }
    }
    @objc func updateSeconds() {
        
        if (totalSeconds! > 0) {
            let seconds = Int(totalSeconds!) % 60
            let minutes = (Int(totalSeconds!) / 60) % 60
            let hours = Int(totalSeconds!) / 3600
            var output = "Time Remaining: "
            
            if (hours == 0) {
                output += "00:"
            } else if (hours < 10) {
                output += "0" + String(hours) + ":"
            } else {
                output += String(hours) + ":"
            }
            
            if (minutes == 0) {
                output += "00:"
            } else if (minutes < 10) {
                output += "0" + String(minutes) + ":"
            } else {
                output += String(minutes) + ":"
            }
            
            if (seconds == 0) {
                output += "00"
            } else if (seconds < 10) {
                output += "0" + String(seconds)
            } else {
                output += String(seconds)
            }
            remainingTimeLabel.text = output
            totalSeconds! -= 1
        } else {
            timer2.invalidate()
            remainingTimeLabel.text = "Time Remaining: 00:00:00"
            buttonOne.setTitle("Stop Music", for: .normal)
            playSound()
        }
    }
    func playSound() {
        player = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource:"mixkit-game-level-music-689",withExtension: "wav")!)
        player.play()
        }
        @IBOutlet weak var backgroundImage: UIImageView!
    }





