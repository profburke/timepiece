//
//  TimepieceFreezeTests.swift
//  Timepiece
//
//  Created by Matthew Burke on 12/30/14.
//  Copyright (c) 2014-2015 BlueDino Software. All rights reserved.
//

import UIKit
import XCTest
import Timepiece



class TimepieceFreezeTests: TimepieceTestCase
{
  let waypast = NSDate(timeIntervalSince1970: 0)
  let anHourFromNow = NSDate(timeIntervalSinceNow: 3600)
  
  
  func testTimeProgressesAfterUnfreeze()
  {
    timepiece.unfreeze()
    
    let t1 = timepiece.now()
    sleep(2)
    let t2 = timepiece.now()
    
    XCTAssert(t1.compare(t2) == .OrderedAscending, "T2 \(t2) should be later than T1 \(t1)")
  }
  
  
  
  
  func core(time: NSDate)
  {
    let now1 = timepiece.now()
    XCTAssert(now1.compare(time) == .OrderedSame, "Now (\(now1) should equal \(time)")
    
    sleep(2)
    
    let now2 = timepiece.now()
    XCTAssert(now2.compare(time) == .OrderedSame, "After a few seconds, now (\(now2) should _still_ equal \(time)")
    
    XCTAssert(now1.isEqualToDate(now2), "now1 should equal now2")
  }
  
  
  
  
  func testFreezeInThePast()
  {
    timepiece.freeze(at:waypast)
    core(waypast)
  }
  
  
  
  
  func testFreezeInTheFuture()
  {
    timepiece.freeze(at: anHourFromNow)
    core(anHourFromNow)
  }
  
  
  
  
  func testScaleDoesNotAffectFreeze()
  {
    timepiece.scale = 23
    timepiece.freeze(at: waypast)
    core(waypast)
  }
  
  
  
  
  func testFreezeNow()
  {
    let now = NSDate()
    timepiece.freeze()
    
    let now1 = timepiece.now()
    XCTAssert(now1.timeIntervalSinceDate(now) < 1, "Now (\(now1) should be within a second of \(now)")
    
    sleep(2)
    
    let now2 = timepiece.now()
    XCTAssert(now2.timeIntervalSinceDate(now) < 1, "After a few seconds, now (\(now2) should _still_ be within a second \(now)")
    
    XCTAssert(now1.isEqualToDate(now2), "now1 should equal now2")
  }

  
}
