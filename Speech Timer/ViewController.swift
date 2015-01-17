//
//  ViewController.swift
//  Speech Timer
//
//  Created by Brooks Newberry on 1/15/15.
//  Copyright (c) 2015 Brooks Newberry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countdown: UILabel!
    @IBOutlet weak var startbtn: UIButton!
    @IBOutlet weak var resetbtn: UIButton!
    //var minutes: Int = 14
    //var warning: Int = 4
    //var stayawake = false
    //var completionmessage:String? = nil
    var timer: NSTimer? = nil
    var started:NSDate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appDefaults = NSUserDefaults.standardUserDefaults()
        //stayawake = appDefaults.boolForKey("stayawake_preference") ?? false
        //completionmessage = appDefaults.stringForKey("completionmessage_preference")
        //minutes = appDefaults.stringForKey("minutes_preference")?.toInt() ?? 14
        //warning = appDefaults.stringForKey("warning_preference")?.toInt() ?? 4
        startbtn.enabled = true
        countdown.text = "\(minutes):00"
        /*
        if completionmessage != nil && completionmessage == "" {
            completionmessage = nil
        }
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var stayawake:Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey("stayawake_preference") ?? false
    }
    
    var minutes:Int {
        return NSUserDefaults.standardUserDefaults().stringForKey("minutes_preference")?.toInt() ?? 14
    }
    
    var warning:Int {
        return NSUserDefaults.standardUserDefaults().stringForKey("warning_preference")?.toInt() ?? 4
    }
    
    var completionmessage:String? {
        if NSUserDefaults.standardUserDefaults().stringForKey("completionmessage_preference") != nil && NSUserDefaults.standardUserDefaults().stringForKey("completionmessage_preference") == "" {
            return nil
        } else {
            return NSUserDefaults.standardUserDefaults().stringForKey("completionmessage_preference")
        }
    }
    
    func countDown(){
        let elapsed = NSDate().timeIntervalSinceDate(started!)
        let minleft = Double(minutes)-(elapsed/60)
        let decleft = minleft-floor(minleft)
        let secleft = String(format: "%02d", Int(decleft*60))
        if minleft >= 0 && decleft > 0 {
            countdown.text = "\(Int(floor(minleft))):\(secleft)"
            if Int(floor(minleft))+1 <= warning {
                countdown.textColor = UIColor.redColor()
            }
        } else {
            resetTimer(completionmessage ?? "0:00")
        }
        
    }
    
    func resetTimer(message:String?){
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        UIApplication.sharedApplication().idleTimerDisabled = stayawake
        countdown.text = message ?? "\(minutes):00"
        countdown.textColor = UIColor.blackColor()
        
        resetbtn.enabled = false
    }
    
    @IBAction func startButtonPressed(sender: UIButton) {
        resetbtn.enabled = true
        countdown.textColor = UIColor.blackColor()
        UIApplication.sharedApplication().idleTimerDisabled = true
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "countDown", userInfo: nil, repeats: true)
        timer?.tolerance = 1.0
        started = NSDate()
        
    }
    @IBAction func resetButtonPressed(sender: UIButton) {
        resetTimer(nil)
    }
    
}

