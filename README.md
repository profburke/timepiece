
# Timepiece

 In order to more easily test time-dependent functionality, you can use Timepiece to

  1. always return the same time (tp.freeze() for "now", tp.freeze(at:) for a specific time)
  2. return a time at some offset in the past or future (e.g. after tp.travel(-3600), tp.now() will return a time an hour prior to "real" now)
     use tp.resume() to return to the present
  3. speed up (tp.scale = 10) or slow down (tp.scale = 0.1) time
  4. you can even get arbitrarily fancy. See TimepieceSequenceOfTimesTests.swift (TODO: rename this...) for examples.

  TODO: 5. replacement for SigTimeNotif

  In fact could implement all functionality in terms of optionalNowFunction. (Why am I not doing it that way?)

  In Timecop, nested blocks can have their own time adjustments. We can do basically the same thing by creating more than 1 Timepiece object



  Inspired some by my needs and some by https://github.com/travisjeffery/timecop .

  Usage: rather than calling NSDate() to get the current datetime, create a Timepiece object, say tp, and
  then call tp.now() whenever you need the current datetime.



