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
  // MARK:- Properties
  
  
  @IBOutlet weak var actualTimeLabel: UILabel!
  @IBOutlet weak var warpedTimeLabel: UILabel!
  @IBOutlet weak var baselineTextField: UITextField!
  @IBOutlet weak var modeController: UISegmentedControl!
  lazy var ticker : NSTimer = NSTimer()
  lazy var datePicker : UIDatePicker = UIDatePicker()
  var mode : Timepiece.Mode?
  var baseline : NSDate?
  var timepiece = Timepiece()
  

  
  // MARK:- View Lifecycle
  
  
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
    warpedTimeLabel.text = timepiece.now().description
    ticker = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
    
    
    let nc = NSNotificationCenter.defaultCenter()
    nc.addObserver(self, selector: "timechange",
      name: TimepieceSignificantTimeChangeNotification, object: nil)
    
    timepiece.scale = 3600
  }
  
  
  func timechange()
  {
    println("BONG!")
  }
  
  
  override func viewDidDisappear(animated: Bool)
  {
    let nc = NSNotificationCenter.defaultCenter()
    nc.removeObserver(self)
    
    ticker.invalidate()
    super.viewDidDisappear(animated)
  }
  
  
  
  
  // MARK:- Handler Methods
  
  
  func setMode()
  {
    timepiece.resume()
    timepiece.unfreeze()

    mode = Timepiece.Mode(rawValue: modeController.selectedSegmentIndex)
    if let m = mode {
      switch (m) {
      case .Normal:
        break
      case .Frozen:
        if let b = baseline {
          timepiece.freeze(at: b)
        }
      case .Traveled:
        if let b = baseline {
          timepiece.travel(to: b)
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
    warpedTimeLabel.text = timepiece.now().description
  }
  
  
}

