//
//  Timepiece.swift
//  Timepiece
//
//  Created by Matthew Burke on 12/30/14.
//  Copyright (c) 2014-2015 BlueDino Software. All rights reserved.
//



// Inspired some by my needs and some by https://github.com/travisjeffery/timecop .

import Foundation

// NOTE: See http://vperi.com/2014/06/03/simulating-type-properties-for-classes-in-swift/ if we wind up switching to a class....

// NOTE: we could implement all the functionality in terms of assigning an appropriate function to optionalNowFunction,
// but I think it might be easier to do it this way...

// TODO: need to handle Significant time notifications...


// TODO: pass in a sequence of times, each successive call to Timepiece.now() returns the next sequence value
// (can possibly accomplish this with optionalNowFunction)

// TODO: have a stack of time adjustments, call Timepiece functions w/blocks (closures) a la Timecop
// NOTE: does implementing TP as a class give us essentially that? (each block can create its own timepiece?)



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

  public var optionalNowFunction: (() -> NSDate)?
  public var scale: Int = 1 { // TODO: guard against invalid values, use fractional values to slow down time?
    didSet {
      if scale == 1 {
        scaleBase = nil
      } else {
        scaleBase = now()
      }
    }
  }
  
  
  
  
  public init()
  {
    // need to create a timer (on a separate thread?) that
    // checks every second for a significant time event (using our warped time)
    // and, if so, posts a notification
  }
  
  
  
  
  deinit
  {
    // need to stop the thread
    // now maybe need a start and stop method separate from init/deinit
    // and call them from init/deinit?
    // (that way we can also call when we go to/come from background?)
    // except---now do we need a global list of timepieces so we can easily start/stop them all?
    // check if there's a notification we can register for?
  }
  
  
  
  
  /*
  
  To implement time scaling we need to note the time the scale takes effect (scaleBase)
  and then delta = (now - scaleBase) * scale
  
  Now if we are unfrozen and untraveled we return scaleBase + delta
  If we are traveling, we return now + difference + delta
  
  */
  
  
  
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
        delta = NSDate().timeIntervalSinceDate(base) * Double(scale)
      }
      return NSDate(timeIntervalSinceNow: difference + delta) // TODO: factor in scale
    }
  }
  
  
  
  
  public func freeze()
  {
    frozen = self.now()
  }
  
  
  
  
  public func freeze(at time: NSDate)
  {
    frozen = time
  }
  
  
  
  
  public func unfreeze()
  {
    frozen = nil
  }
  
  
  
  
  public func travel(timeInterval: NSTimeInterval)
  {
    difference = timeInterval
  }
  
  
  
  
  public func travel(to time: NSDate)
  {
    difference = time.timeIntervalSinceDate(NSDate())
  }
  
  
  
  
  public func resume()
  {
    difference = 0
  }
  
  
}

