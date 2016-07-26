'use strict'
assert = require 'assert'
should = require 'should'
timeFormat = require '..'

describe 'time-format-utils', ->
  describe 'secondsToExtHhmmss(t, type)', ->
    it 'formats a duration as `improved`', ->
      timeFormat.secondsToExtHhmmss(10 * 60 * 60, 'improved') # 10h
        .should.equal "<span class='time-format-utils__duration'><strong>10</strong>:00:00</span>"

    it 'formats a duration as `decimal`', ->
      timeFormat.secondsToExtHhmmss(10 * 60 * 60, 'decimal') # 10h
        .should.equal '10.00 h'

    it 'formats a duration as `classic`', ->
      timeFormat.secondsToExtHhmmss(10 * 60 * 60 + 5 * 60, 'classic') # 10h
        .should.equal '10:05:00'

  describe 'millisecondsToHhmmss(ms, withoutSeconds)', ->
    it 'pretty formats some amount of milliseconds to hh:mm:ss', ->
      timeFormat.millisecondsToHhmmss(1000 * 60 * 60).should.equal '01:00:00'
      timeFormat.millisecondsToHhmmss('' + 1000 * 60 * 60)
        .should.equal '01:00:00'
      timeFormat.millisecondsToHhmmss(NaN).should.equal '0 sec'
      timeFormat.millisecondsToHhmmss(1000 * 60 * 5).should.equal '05:00 min'
      timeFormat.millisecondsToHhmmss(1000 * 5).should.equal '5 sec'

    describe 'if `withoutSeconds == true`', ->
      it 'hides seconds from the output', ->
        timeFormat.millisecondsToHhmmss(1000 * 60 * 60, true).should.equal '1h 00 min'
        timeFormat.millisecondsToHhmmss('' + 1000 * 60 * 60 + 1000 * 40, true)
            .should.equal '100000h 00 min'

  describe 'secondsToHhmm(secs)', ->
    it 'pretty formats some amount of seconds to hh:mm', ->
      timeFormat.secondsToHhmm(60 * 60).should.equal '1:00 h'
      timeFormat.secondsToHhmm(60 * 10).should.equal '0:10 h'

  describe 'secToDecimalHours(secs)', ->
    it 'pretty formats some amount of seconds in hours (hh.hh h)', ->
      timeFormat.secToDecimalHours(60 * 10).should.equal '0.17 h'
      timeFormat.secToDecimalHours(60 * 60 * 3).should.equal '3.00 h'

  describe 'secondsToSmallHhmm(secs)', ->
    it 'pretty formats some amount of seconds in hours (hh:mm)', ->
      timeFormat.secondsToSmallHhmm(60 * 60 * 3).should.equal '3:00'

  describe 'secondsToPrettyHhmm(secs)', ->
    it 'pretty formats some amount of seconds in hours (hh:mm)', ->
      timeFormat.secondsToPrettyHhmm(60 * 60 * 3).should.equal '3 h 00 min'

  describe 'secToHhmmImproved(secs)', ->
    it 'pretty formats some amount of seconds in hours (hh.hh h)', ->
      timeFormat.secToHhmmImproved(60 * 10)
        .should.equal "<span class='time-format-utils__duration'>0:<strong>10</strong>:00</span>"

      timeFormat.secToHhmmImproved(60 * 60 * 10)
        .should.equal "<span class='time-format-utils__duration'><strong>10</strong>:00:00</span>"

      timeFormat.secToHhmmImproved(60 * 60 * 10 + 1 / 3)
        .should.equal "<span class='time-format-utils__duration'><strong>10</strong>:00:00</span>"

      timeFormat.secToHhmmImproved(60 * 60 * 10 + 1 + 1 / 3)
        .should.equal "<span class='time-format-utils__duration'><strong>10</strong>:00:01</span>"

      timeFormat.secToHhmmImproved(10)
        .should.equal "<span class='time-format-utils__duration'>0:00:10</span>"

  describe '_baseSecondsToHhmm(secs, sep, suffix)', ->
    it 'formats a some amount of seconds in hours (hh<sep>mm) ', ->
      timeFormat._baseSecondsToHhmm(60 * 60).should.equal '1:00'
      timeFormat._baseSecondsToHhmm(60 * 60, '-').should.equal '1-00'
      timeFormat._baseSecondsToHhmm(60 * 10, '.').should.equal '0.10'
      timeFormat._baseSecondsToHhmm(60 * 10, undefined, ' time')
        .should.equal '0:10 time'

  describe '_toSnakeCase(str)', ->
    it 'converts strings from camel case to snake case', ->
      timeFormat._toSnakeCase('somethingHere').should.equal 'something_here'
      timeFormat._toSnakeCase('somethingVeryInteresting')
        .should.equal 'something_very_interesting'
      timeFormat._toSnakeCase('SomethingWeird')
        .should.equal 'Something_weird'
      timeFormat._toSnakeCase('somethingH')
        .should.equal 'something_h'

  describe 'compatibility layer', ->
    it 'exposes functions with snake case', ->
      fns = "secondsToExtHhmmss secToHhmmImproved millisecondsToHhmmss
             secToDecimalHours secondsToHhmm secondsToSmallHhmm
             secondsToPrettyHhmm".split(' ')
      compatFns = "seconds_to_ext_hhmmss sec_to_hhmm_improved
                   milliseconds_to_hhmmss sec_to_decimal_hours
                   seconds_to_hhmm seconds_to_small_hhmm
                   seconds_to_pretty_hhmm".split(' ')
      for [fn, compatFn] in zip(fns, compatFns)
        timeFormat.should.have.properties(fn, compatFn)
        timeFormat[fn].should.equal timeFormat[compatFn]

zip = (col1, col2) ->
  for i, e of col1
    [e, col2[i]]
