//
//  TimeSelectorViewController.swift
//  speechtimer
//
//  Created by Brooks Newberry on 1/19/15.
//  Copyright (c) 2015 Brooks Newberry. All rights reserved.
//

import UIKit

class TimeSelectorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var timepicker: UIPickerView!
    var parent:ViewController? = nil
    var times:[Int] = []
    var max = 26
    override func viewDidLoad() {
        super.viewDidLoad()
        timepicker.dataSource = self
        timepicker.delegate = self
        if times.count < 1 {
            times = []
            for i in 0...30 {
                times.append(i)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("prepare for segue.")
        
        parent = sender as? ViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return max
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return String(row)
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if parent != nil {
            parent!.childMessage("hello.")
        } else {
            println("picked, no parent.")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
