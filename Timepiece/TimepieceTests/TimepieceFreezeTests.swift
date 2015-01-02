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
    Timepiece.unfreeze()
    
    let t1 = Timepiece.now()
    sleep(2)
    let t2 = Timepiece.now()
    
    XCTAssert(t1.compare(t2) == .OrderedAscending, "T2 \(t2) should be later than T1 \(t1)")
  }
  
  
  
  
  func core(time: NSDate)
  {
    let now1 = Timepiece.now()
    XCTAssert(now1.compare(time) == .OrderedSame, "Now (\(now1) should equal \(time)")
    
    sleep(2)
    
    let now2 = Timepiece.now()
    XCTAssert(now2.compare(time) == .OrderedSame, "After a few seconds, now (\(now2) should _still_ equal \(time)")
    
    XCTAssert(now1.isEqualToDate(now2), "now1 should equal now2")
  }
  
  
  
  
  func testFreezeInThePast()
  {
    Timepiece.freeze(at:waypast)
    core(waypast)
  }
  
  
  
  
  func testFreezeInTheFuture()
  {
    Timepiece.freeze(at: anHourFromNow)
    core(anHourFromNow)
  }
  
  
  
  
  func testScaleDoesNotAffectFreeze()
  {
    Timepiece.scale = 23
    Timepiece.freeze(at: waypast)
    core(waypast)
  }
  
  
  
  
  func testFreezeNow()
  {
    let now = NSDate()
    Timepiece.freeze()
    
    let now1 = Timepiece.now()
    XCTAssert(now1.timeIntervalSinceDate(now) < 1, "Now (\(now1) should be within a second of \(now)")
    
    sleep(2)
    
    let now2 = Timepiece.now()
    XCTAssert(now2.timeIntervalSinceDate(now) < 1, "After a few seconds, now (\(now2) should _still_ be within a second \(now)")
    
    XCTAssert(now1.isEqualToDate(now2), "now1 should equal now2")
  }

  
}
