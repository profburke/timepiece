//
//  TimepieceTestCase.swift
//  Timepiece
//
//  Created by Matthew Burke on 12/30/14.
//  Copyright (c) 2014-2015 BlueDino Software. All rights reserved.
//

import UIKit
import XCTest
import Timepiece



class TimepieceTestCase: XCTestCase
{
  override func setUp()
  {
    Timepiece.unfreeze()
    Timepiece.resume()
    Timepiece.scale = 1
  }
  
  
}