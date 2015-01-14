//
//  TimepieceSequenceOfTimesTests.swift
//  Timepiece
//
//  Created by Matthew Burke on 1/2/15.
//  Copyright (c) 2015 BlueDino Software. All rights reserved.
//

import UIKit
import XCTest
import Timepiece



class TimepieceSequenceOfTimesTests: TimepieceTestCase
{
  
  func testSequence()
  {
    
    let mydates: [NSDate] = [
      NSDate(timeIntervalSince1970: 0),
      NSDate(timeIntervalSinceReferenceDate: 0),
      NSDate.distantFuture() as NSDate,
      NSDate.distantPast() as NSDate,
      NSDate(timeIntervalSinceNow: 0)
    ]
    
    
    var index = 0
    
    let f = { () -> NSDate in
      let tindex = (index >= mydates.count) ? mydates.count - 1 : index++
      return mydates[tindex]
    }
    
    timepiece.optionalNowFunction = f
    
    XCTAssert(timepiece.now().isEqualToDate(mydates[0]), "first time isn't \(mydates[0])")
    XCTAssert(timepiece.now().isEqualToDate(mydates[1]), "second time isn't \(mydates[0])")
    XCTAssert(timepiece.now().isEqualToDate(mydates[2]), "third time isn't \(mydates[0])")
    XCTAssert(timepiece.now().isEqualToDate(mydates[3]), "fourth time isn't \(mydates[0])")
    XCTAssert(timepiece.now().isEqualToDate(mydates[4]), "fifth time isn't \(mydates[0])")
  }
  
  
}