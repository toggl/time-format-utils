'use strict'
###*
 * Formats an amount of seconds in the specified "duration format"
 *
 * @param {Number} t Amount in seconds
 * @param {String} type One of 'improved', 'decimal' and 'classic'
 * @return {String}
 *
###
exports.secondsToExtHhmmss = (t, type) ->
  if (type is 'improved')
    exports.secToHhmmImproved(t)
  else if (type is 'decimal')
    exports.secToDecimalHours(t)
  else
    exports.millisecondsToHhmmss(t * 1000)

###*
 * Pretty formats some amount of milliseconds in a span `duration` tag.
 *
 * @param {Number} seconds
 * @return {String}
###
exports.secToHhmmImproved = (seconds) ->
  if not seconds? then return ''

  hours = Math.floor(seconds / 3600)
  minutes = Math.floor((seconds % 3600) / 60)
  seconds = seconds % 60

  sminutes = leftPad(minutes, 2, '0')
  sseconds = leftPad((seconds % 60), 2, '0')

  if hours > 0
    formatted = "<strong>#{hours}</strong>:#{sminutes}:#{sseconds}"
  else if minutes > 0
    formatted = "#{hours}:<strong>#{sminutes}</strong>:#{sseconds}"
  else
    formatted = "#{hours}:#{sminutes}:#{sseconds}"

  "<span class='duration'>#{formatted}</span>"

###*
 * Pretty formats some amount of milliseconds in "hh:mm:ss".
 *
 * @param {Number} ms
 * @return {String}
###
exports.millisecondsToHhmmss = (ms) ->
  if not (typeof ms is 'number')
    ms = parseInt(ms, 10)

  if isNaN(ms)
    return '0 sec'

  hours = Math.floor(ms / 3600000)
  minutes = Math.floor((ms % 3600000) / 60000)
  seconds = Math.floor((ms % 60000) / 1000)

  if !hours
    if !minutes
      return seconds + ' sec'

    seconds = leftPad(seconds, 2, '0')
    minutes = leftPad(minutes, 2, '0')
    return minutes + ':' + seconds + ' min'

  minutes = leftPad(minutes, 2, '0')
  seconds = leftPad(seconds, 2, '0')
  hours = leftPad(hours, 2, '0')

  hours + ':' + minutes + ':' + seconds

###*
 * Formats some amount of seconds in hours with two decimal cases ("hh.hh h").
 *
 * @param {Number} secs
 * @return {String}
###
exports.secToDecimalHours = (secs) -> (secs / 60 / 60).toFixed(2) + " h"

###*
 * Formats some amount of seconds in "hh:mm" with a variable separator `sep` and
 * suffix `suffix`.
 *
 * @param {Number} secs The amount of seconds to format
 * @param {String} sep A separator
 * @param {String} suffix A suffix
 * @return {String}
###
baseSecondsToHhmm = exports._baseSecondsToHhmm =
(secs, sep = ':', suffix = '') ->
  hours = '' + Math.floor(secs / 3600)
  minutes = leftPad('' + Math.floor(secs % 3600 / 60), 2, '0')
  hours + sep + minutes + suffix

###*
 * Pads a value `val` to the left by `size` `ch` or `' '` characters.
 *
 * @param {Mixed} val The value to pad
 * @param {Number} size The padding's size
 * @param {String} [ch=' '] The padding character
 * @return {String} The padding result
###
leftPad = exports._leftPad = (val, size, ch = ' ') ->
  result = '' + val
  while result.length < size
    result = ch + result
  result

# Formatting helper functions:
exports.secondsToHhmm = (secs) -> baseSecondsToHhmm(secs, ':', ' h')
exports.secondsToSmallHhmm = (secs) -> baseSecondsToHhmm(secs, ':')
exports.secondsToPrettyHhmm = (secs) -> baseSecondsToHhmm(secs, ' h ', ' min')

###*
 * Converts a string to snake case
 *
 * @param {String} str
 * @return {String}
###
toSnakeCase = exports._toSnakeCase = (str) ->
  str.replace(/.([A-Z])/g, (m) -> m[0] + '_' + m[1].toLowerCase())

# Compatibility layer
for name, fn of exports
  continue if name.charAt(0) == '_'
  exports[toSnakeCase(name)] = fn
