//
//  ViewController.swift
//  TimepieceDemo
//
//  Created by Matthew Burke on 12/30/14.
//  Copyright (c) 2014-2015 BlueDino Software. All rights reserved.
//


import UIKit
import Timepiece



class ViewController: UIViewController, UITextFieldDelegate
{
  @IBOutlet weak var actualTimeLabel: UILabel!
  @IBOutlet weak var warpedTimeLabel: UILabel!
  @IBOutlet weak var baselineTextField: UITextField!
  @IBOutlet weak var modeController: UISegmentedControl!
  var ticker : NSTimer?
  var baseline : NSDate?
  var datePicker : UIDatePicker = UIDatePicker()
  var mode : Timepiece.Mode?
  
  

  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    baselineTextField.delegate = self
    
    let viewWidth = self.view.frame.width
    let frame = CGRect(x: 0, y: 0, width: Int(viewWidth), height: 40)
    
    var setDateButton = UIButton(frame: frame)
    setDateButton.setTitle("Set Date", forState: .Normal)
    setDateButton.addTarget(self, action: "setDate", forControlEvents: .TouchUpInside)
    
    var dateAccessory = UIView(frame: frame)
    dateAccessory.backgroundColor = UIColor.lightGrayColor()
    dateAccessory.addSubview(setDateButton)
    
    baselineTextField.inputView = datePicker
    baselineTextField.inputAccessoryView = dateAccessory
    
    modeController.addTarget(self, action: "setMode", forControlEvents: .ValueChanged)
  }
  
  
  
  
  override func viewDidAppear(animated: Bool)
  {
    super.viewDidAppear(animated)
    actualTimeLabel.text = NSDate().description
    warpedTimeLabel.text = Timepiece.now().description
    ticker = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
  }
  
  
  
  
  override func viewDidDisappear(animated: Bool)
  {
    ticker?.invalidate()
    super.viewDidDisappear(animated)
  }
  
  
  
  
  func setMode()
  {
    mode = Timepiece.Mode(rawValue: modeController.selectedSegmentIndex)
    Timepiece.resume()
    Timepiece.unfreeze()
    if let m = mode {
      switch (m) {
      case .Normal:
        break
      case .Frozen:
        if let b = baseline {
          Timepiece.freeze(at: b)
        }
      case .Traveled:
        if let b = baseline {
          Timepiece.travel(to: b)
        }
      }
    }
  }
  
  
  
  
  func setDate()
  {
    baseline = datePicker.date
    baselineTextField.text = baseline?.description
    baselineTextField.resignFirstResponder()
    
    setMode()
  }
  
  
  
  
  func update()
  {
    actualTimeLabel.text = NSDate().description
    warpedTimeLabel.text = Timepiece.now().description
  }
  
  
}

