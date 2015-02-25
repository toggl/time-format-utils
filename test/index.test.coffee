'use strict'
assert = require 'assert'
should = require 'should'
timeFormat = require '..'

describe 'time-format', ->
  describe 'secondsToExtHhmmss(t, type)', ->
    it 'formats a duration as `improved`', ->
      timeFormat.secondsToExtHhmmss(10 * 60 * 60, 'improved') # 10h
        .should.equal "<span class='duration'><strong>10</strong>:00:00</span>"

    it 'formats a duration as `decimal`', ->
      timeFormat.secondsToExtHhmmss(10 * 60 * 60, 'decimal') # 10h
        .should.equal '10.00 h'

    it 'formats a duration as `classic`', ->
      timeFormat.secondsToExtHhmmss(10 * 60 * 60 + 5 * 60, 'classic') # 10h
        .should.equal '10:05:00'

  describe 'millisecondsToHhmmss(ms)', ->
    it 'pretty formats some amount of milliseconds to hh:mm:ss', ->
      timeFormat.millisecondsToHhmmss(1000 * 60 * 60).should.equal '01:00:00'

  describe 'secondsToHhmm(secs)', ->
    it 'pretty formats some amount of seconds to hh:mm', ->
      timeFormat.secondsToHhmm(60 * 60).should.equal '1:00 h'
      timeFormat.secondsToHhmm(60 * 10).should.equal '0:10 h'

  describe 'secToDecimalHours(secs)', ->
    it 'pretty formats some amount of seconds in hours (hh.hh h)', ->
      timeFormat.secToDecimalHours(60 * 10).should.equal '0.17 h'
      timeFormat.secToDecimalHours(60 * 60 * 3).should.equal '3.00 h'

  describe 'secToHhmmImproved(secs)', ->
    it 'pretty formats some amount of seconds in hours (hh.hh h)', ->
      timeFormat.secToHhmmImproved(60 * 10)
        .should.equal "<span class='duration'>0:<strong>10</strong>:00</span>"

      timeFormat.secToHhmmImproved(60 * 60 * 10)
        .should.equal "<span class='duration'><strong>10</strong>:00:00</span>"

      timeFormat.secToHhmmImproved(10)
        .should.equal "<span class='duration'>0:00:10</span>"
