//
//  TimepieceTravelDurationTests.swift
//  Timepiece
//
//  Created by Matthew Burke on 12/30/14.
//  Copyright (c) 2014-2015 BlueDino Software. All rights reserved.
//

import UIKit
import XCTest
import Timepiece

class TimpieceTravelDurationTests: TimepieceTestCase
{
  
  
  func core(duration: NSTimeInterval)
  {
    timepiece.travel(duration)
    
    var (realtime, simtime) = (NSDate(), timepiece.now())
    
    XCTAssertEqualWithAccuracy(simtime.timeIntervalSinceDate(realtime),duration, 1.0,
      "Time difference should be \(duration), was \(simtime.timeIntervalSinceDate(realtime))")
    
    sleep(2)
    
    (realtime, simtime) = (NSDate(), timepiece.now())
    
    XCTAssertEqualWithAccuracy(simtime.timeIntervalSinceDate(realtime),duration, 1.0,
      "Time difference should be \(duration), was \(simtime.timeIntervalSinceDate(realtime))")
  }
  
  
  
  
  func testNegativeDuration()
  {
    core(-7123)
  }
  
  
  
  
  func testPositiveDuration()
  {
    core(4518)
  }
  
  
}


