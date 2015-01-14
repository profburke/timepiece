//
//  DateExtension.swift
//  Timepiece
//
//  Created by Matthew Burke on 1/13/15.
//  Copyright (c) 2015 BlueDino Software. All rights reserved.
//

import Foundation

extension NSDate
{
  

  private class func componentFlags() -> NSCalendarUnit
  {
    return .YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit |
      .WeekCalendarUnit | .HourCalendarUnit | .MinuteCalendarUnit |
      .SecondCalendarUnit | .WeekdayCalendarUnit |
      .WeekdayOrdinalCalendarUnit | .CalendarUnitWeekOfYear
  }
  
  
  
  
  private class func components(#fromDate: NSDate) -> NSDateComponents!
  {
    return NSCalendar.currentCalendar().components(NSDate.componentFlags(),
      fromDate: fromDate)
  }
  
  
  
  
  private func components() -> NSDateComponents
  {
    return NSDate.components(fromDate: self)!
  }
  
  
  
  
  public func dateAtEndOfDay() -> NSDate
  {
    var components = self.components()
    components.hour = 23
    components.minute = 59
    components.second = 59
    return NSCalendar.currentCalendar().dateFromComponents(components)!
  }



}


