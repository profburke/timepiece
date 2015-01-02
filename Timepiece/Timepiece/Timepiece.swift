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

// TODO: implement scale
// TODO: do we want scale to be nonzero real with fractions slowing time down?
// TODO: guard scale against being <= 0?
// TODO: need to handle Significant time notifications...


// TODO: pass in a sequence of times, each successive call to Timepiece.now() returns the next sequence value
// (can possibly accomplish this with optionalNowFunction)

// TODO: have a stack of time adjustments, call Timepiece functions w/blocks (closures) a la Timecop



public struct Timepiece
{
  private static var frozen : NSDate?
  private static var difference : NSTimeInterval?
  public static var scale = 1
  public static var optionalNowFunction: (() -> NSDate)?
  
  
  public enum Mode: Int
  {
    case Normal = 0
    case Frozen
    case Traveled
  }
  
  /*
  
  To implement time scaling we need to note the time the scale takes effect (scaleBase)
  and then delta = (now - scaleBase) * scale
  
  Now if we are unfrozen and untraveled we return scaleBase + delta
  If we are traveling, we return now + difference + delta
  
  */
  
  
  
  public static func now() -> NSDate
  {
    // return result from custom time generator
    if let nowFunction = optionalNowFunction {
      let result = nowFunction()
      return result
      
      // see if we're frozen
    } else if let result = frozen {
      return result
      
      // see if we've traveled
    } else if let delta = difference {
      return NSDate(timeIntervalSinceNow: delta) // TODO: factor in scale
      
      // else we're not mucking with time
    } else {
      return NSDate() // TODO: factor in scale
    }
  }
  
  
  
  
  public static func freeze(at time : NSDate = Timepiece.now())
  {
    frozen = time
  }
  
  
  
  
  public static func unfreeze()
  {
    frozen = nil
  }
  
  
  
  
  public static func travel(timeInterval : NSTimeInterval)
  {
    difference = timeInterval
  }
  
  
  
  
  public static func travel(to time : NSDate)
  {
    difference = time.timeIntervalSinceDate(NSDate())
  }
  
  
  
  
  public static func resume()
  {
    difference = nil
  }
  
  
}

