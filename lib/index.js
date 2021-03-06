// Generated by CoffeeScript 1.10.0
(function() {
  'use strict';

  /**
   * Formats an amount of seconds in the specified "duration format"
   *
   * @param {Number} t Amount in seconds
   * @param {String} type One of 'improved', 'decimal' and 'classic'
   * @return {String}
   *
   */
  var baseSecondsToHhmm, fn, leftPad, name, toSnakeCase;

  exports.secondsToExtHhmmss = function(t, type, options) {
    if (options == null) {
      options = {
        html: true
      };
    }
    if (type === 'improved') {
      return exports.secToHhmmImproved(t, options);
    } else if (type === 'decimal') {
      return exports.secToDecimalHours(t);
    } else {
      return exports.millisecondsToHhmmss(t * 1000);
    }
  };


  /**
   * Pretty formats some amount of milliseconds in a span `duration` tag.
   *
   * @param {Number} seconds
   * @return {String}
   */

  exports.secToHhmmImproved = function(seconds, options) {
    var formatted, hours, minutes, sminutes, sseconds;
    if (options == null) {
      options = {
        html: true
      };
    }
    if (seconds == null) {
      return '';
    }
    hours = Math.floor(seconds / 3600);
    minutes = Math.floor((seconds % 3600) / 60);
    seconds = Math.floor(seconds % 60);
    sminutes = leftPad(minutes, 2, '0');
    sseconds = leftPad(seconds % 60, 2, '0');
    if (!options.html) {
      return hours + ":" + sminutes + ":" + sseconds;
    }
    if (hours > 0) {
      formatted = "<strong>" + hours + "</strong>:" + sminutes + ":" + sseconds;
    } else if (minutes > 0) {
      formatted = hours + ":<strong>" + sminutes + "</strong>:" + sseconds;
    } else {
      formatted = hours + ":" + sminutes + ":" + sseconds;
    }
    return "<span class='time-format-utils__duration'>" + formatted + "</span>";
  };


  /**
   * Pretty formats some amount of milliseconds in "hh:mm:ss".
   *
   * @param {Number} ms
   * @return {String}
   */

  exports.millisecondsToHhmmss = function(ms, withoutSeconds) {
    var hours, minutes, seconds;
    if (!(typeof ms === 'number')) {
      ms = parseInt(ms, 10);
    }
    if (isNaN(ms)) {
      return '0 sec';
    }
    hours = Math.floor(ms / 3600000);
    minutes = Math.floor((ms % 3600000) / 60000);
    seconds = Math.floor((ms % 60000) / 1000);
    if (withoutSeconds) {
      if (!hours) {
        return minutes + ' min';
      } else {
        return hours + 'h ' + leftPad(minutes, 2, '0') + ' min';
      }
    }
    if (!hours) {
      if (!minutes) {
        return seconds + ' sec';
      }
      seconds = leftPad(seconds, 2, '0');
      minutes = leftPad(minutes, 2, '0');
      return minutes + ':' + seconds + ' min';
    }
    minutes = leftPad(minutes, 2, '0');
    seconds = leftPad(seconds, 2, '0');
    hours = leftPad(hours, 2, '0');
    return hours + ':' + minutes + ':' + seconds;
  };


  /**
   * Formats some amount of seconds in hours with two decimal cases ("hh.hh h").
   *
   * @param {Number} secs
   * @return {String}
   */

  exports.secToDecimalHours = function(secs) {
    return (secs / 60 / 60).toFixed(2) + " h";
  };


  /**
   * Formats some amount of seconds in "hh:mm" with a variable separator `sep` and
   * suffix `suffix`.
   *
   * @param {Number} secs The amount of seconds to format
   * @param {String} sep A separator
   * @param {String} suffix A suffix
   * @return {String}
   */

  baseSecondsToHhmm = exports._baseSecondsToHhmm = function(secs, sep, suffix) {
    var hours, minutes;
    if (sep == null) {
      sep = ':';
    }
    if (suffix == null) {
      suffix = '';
    }
    hours = '' + Math.floor(secs / 3600);
    minutes = leftPad('' + Math.floor(secs % 3600 / 60), 2, '0');
    return hours + sep + minutes + suffix;
  };


  /**
   * Pads a value `val` to the left by `size` `ch` or `' '` characters.
   *
   * @param {Mixed} val The value to pad
   * @param {Number} size The padding's size
   * @param {String} [ch=' '] The padding character
   * @return {String} The padding result
   */

  leftPad = exports._leftPad = function(val, size, ch) {
    var result;
    if (ch == null) {
      ch = ' ';
    }
    result = '' + val;
    while (result.length < size) {
      result = ch + result;
    }
    return result;
  };

  exports.secondsToHhmm = function(secs) {
    return baseSecondsToHhmm(secs, ':', ' h');
  };

  exports.secondsToSmallHhmm = function(secs) {
    return baseSecondsToHhmm(secs, ':');
  };

  exports.secondsToPrettyHhmm = function(secs) {
    return baseSecondsToHhmm(secs, ' h ', ' min');
  };


  /**
   * Converts a string to snake case
   *
   * @param {String} str
   * @return {String}
   */

  toSnakeCase = exports._toSnakeCase = function(str) {
    return str.replace(/.([A-Z])/g, function(m) {
      return m[0] + '_' + m[1].toLowerCase();
    });
  };

  for (name in exports) {
    fn = exports[name];
    if (name.charAt(0) === '_') {
      continue;
    }
    exports[toSnakeCase(name)] = fn;
  }

}).call(this);
