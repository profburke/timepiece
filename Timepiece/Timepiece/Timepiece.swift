//
//  Timepiece.swift
//  Timepiece
//
//  Created by Matthew Burke on 12/30/14.
//  Copyright (c) 2014-2015 BlueDino Software. All rights reserved.
//

import Foundation


// Sent at "midnight"
public let TimepieceSignificantTimeChangeNotification = "TimepieceSignificantTimeChangeNotification"



public class Timepiece
{

  public enum Mode: Int
  {
    case Normal = 0
    case Frozen
    case Traveled
  }
  
  private var frozen: NSDate?
  private var scaleBase: NSDate?
  private var difference: NSTimeInterval = 0

  private lazy var significantTimeChangeTimer = NSTimer()
  
  public var optionalNowFunction: (() -> NSDate)?
  public var scale: Float = 1 {
    // TODO: guard against invalid values
    didSet {
      if scale == 1 {
        scaleBase = nil
      } else {
        scaleBase = now()
      }
      adjustSignificantTimeChangeTimer()
    }
  }
  
  
  

  // TODO: convenience initializers that set scale, base, frozen, etc.?
  public init()
  {
    adjustSignificantTimeChangeTimer()
  }
  
  
  
  
  deinit
  {
    // Maybe need a start and stop method separate from init/deinit
    // and call them from init/deinit?
    //
    // I.e. how do we deal with app switching between foreground and background?
    significantTimeChangeTimer.invalidate()
  }
  
  
  

  @objc public func postSignificantTimeChangeNotification()
  {
    let notificationCenter = NSNotificationCenter.defaultCenter()
    notificationCenter.postNotificationName(TimepieceSignificantTimeChangeNotification, object: self)
    adjustSignificantTimeChangeTimer()
  }
  
  
  
  
  private func adjustSignificantTimeChangeTimer()
  {
    significantTimeChangeTimer.invalidate()
    if frozen == nil {
      let delta = now().dateAtEndOfDay().timeIntervalSinceDate(now())/NSTimeInterval(scale)
      significantTimeChangeTimer = NSTimer.scheduledTimerWithTimeInterval(delta,
        target: self,
        selector: "postSignificantTimeChangeNotification",
        userInfo: nil,
        repeats: false)
    }
  }
  
  

  
  public func now() -> NSDate
  {
    // if custom time generator exists, use it
    if let nowFunction = optionalNowFunction {
      let result = nowFunction()
      return result
      
    // see if we're frozen
    } else if let result = frozen {
      return result
      
    // else we're not mucking with time except, perhapse, scale
    } else {
      var delta: NSTimeInterval = 0
      if let base = scaleBase {
        delta = NSDate().timeIntervalSinceDate(base) * NSTimeInterval(scale)
      }
      return NSDate(timeIntervalSinceNow: difference + delta)
    }
  }
  
  
  
  
  public func freeze()
  {
    frozen = self.now()
    adjustSignificantTimeChangeTimer()
  }
  
  
  
  
  public func freeze(at time: NSDate)
  {
    frozen = time
    adjustSignificantTimeChangeTimer()
  }
  
  
  
  
  public func unfreeze()
  {
    frozen = nil
    adjustSignificantTimeChangeTimer()
  }
  
  
  
  
  public func travel(timeInterval: NSTimeInterval)
  {
    difference = timeInterval
    adjustSignificantTimeChangeTimer()
  }
  
  
  
  
  public func travel(to time: NSDate)
  {
    difference = time.timeIntervalSinceDate(NSDate())
    adjustSignificantTimeChangeTimer()
  }
  
  
  
  
  public func resume()
  {
    difference = 0
    adjustSignificantTimeChangeTimer()
  }
  
  
}

