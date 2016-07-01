//
//  ViewController.swift
//  LeanCafeTimer
//
//  Created by Todd Cardoso on 2016-06-13.
//  Copyright © 2016 TJC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var countingLabel: UILabel!
    @IBOutlet weak var extensionLabel: UILabel!
    @IBOutlet weak var statusBar: UIProgressView!

    var progress: Float = 0.0
    var startChime : AVAudioPlayer!
    var stopChime : AVAudioPlayer!
    var endChime : AVAudioPlayer!
    var pauseChime : AVAudioPlayer!
    var timerA = NSTimer()
    var timerB = NSTimer()
//    var counterSec = 0
//    var counterMs = 0
    var counterMin = 5
    var counterSec = 0
    
    
    var extCounterMin = 2
    var extCounterSec = 0
    
    
    
    func playEndChime(){
        do {
            self.endChime =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("choirchime", ofType: "wav")!))
            self.endChime?.prepareToPlay()
            self.endChime?.volume = 1
            self.endChime.play()
            
        } catch {
            print("Error")
        }
    }
    
    func playPauseChime(){
        do {
            self.pauseChime =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("pause", ofType: "wav")!))
            self.pauseChime?.prepareToPlay()
            self.pauseChime?.volume = 1
            self.pauseChime.play()
            
        } catch {
            print("Error")
        }
    }
    
    func playStopChime(){
        do {
            self.stopChime =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("beep2", ofType: "wav")!))
            self.stopChime?.prepareToPlay()
            self.stopChime?.volume = 1
            self.stopChime.play()
            
        } catch {
            print("Error")
        }
    }
    
    func playStartChime(){
        do {
            self.startChime =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("beep3", ofType: "wav")!))
            self.startChime?.prepareToPlay()
            self.startChime?.volume = 1
            self.startChime.play()
            
        } catch {
            print("Error")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        countingLabel.text = String(format: "%2d:%02d", counterMin, counterSec)
        extensionLabel.text = String(format: "%2d:%02d", extCounterMin, extCounterSec)
        progress = 0
        statusBar.progress = progress
        
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "bg4")?.drawAsPatternInRect(self.view.bounds)
//        
//        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
//        
//        UIGraphicsEndImageContext()
//        
//        self.view.backgroundColor = UIColor(patternImage: image)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateProgressBar(){
        print(progress)
        if progress >= 1.0 {
            print("progress is over one ")
            progress = 0.1
            statusBar.progress = progress
        }
        else {
            progress += 0.1
            statusBar.progress = progress
        }
    }

    @IBAction func startButton(sender: AnyObject) {
        
        if timerA.valid == false {
            timerA = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.updateCounter), userInfo: nil, repeats: true)
            print("Start Timer")
            playStartChime()
            
        }
        else {
            print("Timer Active")
        }
    }
    
    @IBAction func pausebutton(sender: AnyObject) {
    
        timerA.invalidate()
        playPauseChime()
        print("Timer Paused")
    }
    
    @IBAction func stopButton(sender: AnyObject) {
        timerA.invalidate()
        counterMin = 5
        counterSec = 0
//        counterMs = 0
        countingLabel.text = String(format: "%2d:%02d", counterMin, counterSec)
        playStopChime()
        progress = 0
        statusBar.progress = progress

    }
    
    func updateCounter() {
        if counterMin == 0 && counterSec == 0 {
            timerA.invalidate()
            counterMin = 5
            counterSec = 0
//            counterMs = 0
            print("timer completed")
            playEndChime()

        }
        else if counterSec == 0 {
            counterSec = 59
            counterMin -= 1
        }
        else {
            counterSec -= 1
            updateProgressBar()
        }
        countingLabel.text = String(format: "%2d:%02d", counterMin, counterSec)
        
    }
    
    // extension timer
    
    
    @IBAction func extStartButton(sender: AnyObject) {
        
        
        if timerB.valid == false {
            timerB = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(ViewController.updateExtensionCounter), userInfo: nil, repeats: true)
            print("Start Extension Timer")
            playStartChime()
        }
        else {
            print("Extension Timer Active")
        }
        
    }
    
    
    @IBAction func extPauseButton(sender: AnyObject) {
        timerB.invalidate()
        playPauseChime()
        print("Extension Timer Paused")
        
    }
    
    @IBAction func extResetButton(sender: AnyObject) {
        
        timerB.invalidate()
        extCounterMin = 2
        extCounterSec = 0
        extensionLabel.text = String(format: "%2d:%02d", extCounterMin, extCounterSec)
        playStopChime()
    }
    
    func updateExtensionCounter() {
        if extCounterMin == 0 && extCounterSec == 0 {
            timerB.invalidate()
            extCounterMin = 2
            extCounterSec = 0
            //            counterMs = 0
            print("timer completed")
            playEndChime()

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

