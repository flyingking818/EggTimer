//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.

//  Enhancements by Jeremy Wang
//  Last updated: 3/3/2022
//  1) Percentage status of completion report
//  2) Count down timer :)
//  3) Hourly class count down timer!

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //enhancement with status update
    @IBOutlet weak var percentageDone: UILabel!
    
    
    let eggTimes = ["Soft": 180, "Medium": 240, "Hard": 420] //dictionary (key: matching value)
    var timer = Timer()
    var player: AVAudioPlayer!
    var totalTime = 0
    var secondsPassed = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!  //optional! A safer way for processing to allow programmer make some predictions! !-> please open the box!
    
        totalTime = eggTimes[hardness]!  //dictionary is similar to an array (Lookup function)

        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness // possible enhancement!

        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)  // possbible enhancement: you can create a timer for display!!!
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1      //auto increment! counter!
            progressBar.progress = Float(secondsPassed) / Float(totalTime)  // this is actually the percentage!
            print(Float(secondsPassed) / Float(totalTime))  //debugging purpose
            
            //==========My enhancement: Update %=========
            let formatter = NumberFormatter()
            formatter.numberStyle = .percent
            formatter.minimumIntegerDigits = 1
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            
            formatter.locale = Locale(identifier: "en_US")
            let percent = formatter.string(from: NSDecimalNumber(decimal: Decimal(secondsPassed) / Decimal(totalTime)))
            percentageDone.text = percent! + " done!"   //String manipulation! Append text to the previous one
            //==========My enhancement: Update %=========
                      
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!" // enhancement!
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") // file path structure! location!
            player = try! AVAudioPlayer(contentsOf: url!) // try... catch... operation might not be successful!
            player.play()
        }
    }
    
}
