//
//  ViewController.swift
//  LeanCafeTimer
//
//  Created by Todd Cardoso on 2016-06-13.
//  Copyright © 2016 TJC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countingLabel: UILabel!
    @IBOutlet weak var extensionLabel: UILabel!
    
    var timerA = NSTimer()
    var timerB = NSTimer()
//    var counterSec = 0
//    var counterMs = 0
    var counterMin = 5
    var counterSec = 0
    
    
    var extCounterMin = 2
    var extCounterSec = 0

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        countingLabel.text = String(format: "%2d:%02d", counterMin, counterSec)
        extensionLabel.text = String(format: "%2d:%02d", extCounterMin, extCounterSec)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startButton(sender: AnyObject) {
        
        if timerA.valid == false {
            timerA = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
            print("Start Timer")
        }
        else {
            print("Timer Active")
        }
    }
    
    @IBAction func pausebutton(sender: AnyObject) {
    
        timerA.invalidate()
        print("Timer Paused")
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        timerA.invalidate()
        counterMin = 5
        counterSec = 0
//        counterMs = 0
        countingLabel.text = String(format: "%2d:%02d", counterMin, counterSec)
    
    }
    
    func updateCounter() {
        if counterMin == 0 && counterSec == 0 {
            timerA.invalidate()
            counterMin = 5
            counterSec = 0
//            counterMs = 0
            print("timer completed")
        }
        else if counterSec == 0 {
            counterSec = 59
            counterMin -= 1
        }
        else {
            counterSec -= 1
        }
        countingLabel.text = String(format: "%2d:%02d", counterMin, counterSec)
        
    }
    
    // extension timer
    
    
    @IBAction func extStartButton(sender: AnyObject) {
        
        
        if timerB.valid == false {
            timerB = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.updateExtensionCounter), userInfo: nil, repeats: true)
            print("Start Extension Timer")
        }
        else {
            print("Extension Timer Active")
        }
        
    }
    
    
    @IBAction func extPauseButton(sender: AnyObject) {
        timerB.invalidate()
        print("Extension Timer Paused")
        
    }
    
    @IBAction func extResetButton(sender: AnyObject) {
        
        timerB.invalidate()
        extCounterMin = 2
        extCounterSec = 0
        extensionLabel.text = String(format: "%2d:%02d", extCounterMin, extCounterSec)
    }
    
    func updateExtensionCounter() {
        if extCounterMin == 0 && extCounterSec == 0 {
            timerB.invalidate()
            extCounterMin = 2
            extCounterSec = 0
            //            counterMs = 0
            print("timer completed")
        }
        else if extCounterSec == 0 {
            extCounterSec = 59
            extCounterMin -= 1
        }
        else {
            extCounterSec -= 1
        }
        extensionLabel.text = String(format: "%2d:%02d", extCounterMin, extCounterSec)
        
    }
    
    
}

