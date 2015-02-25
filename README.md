time-formatter
==============
Simple utilities for fast duration formatting.

# External API
## secondsToExtHhmmss(t, type)

Formats an amount of seconds in the specified "duration format"

### Params:

* **Number** *t* Amount in seconds
* **String** *type* One of 'improved', 'decimal' and 'classic'

### Return:

* **String**

## secToHhmmImproved(seconds)

Pretty formats some amount of milliseconds in a span `duration` tag.

### Params:

* **Number** *seconds*

### Return:

* **String**

## millisecondsToHhmmss(ms)

Pretty formats some amount of milliseconds in "hh:mm:ss".

### Params:

* **Number** *ms*

### Return:

* **String**

## secToDecimalHours(secs)

Formats some amount of seconds in hours with two decimal cases ("hh.hh h").

### Params:

* **Number** *secs*

### Return:

* **String**

# Helper functions (aliases)
- `secondsToHhmm(secs)` is an alias to `baseSecondsToHhmm(secs, ':', ' h')`
- `secondsToSmallHhmm(secs)` is an alias to `baseSecondsToHhmm(secs, ':')`
- `secondsToPrettyHhmm(secs)` is an alias to `baseSecondsToHhmm(secs, ' h ', ' min')`

# Internal API
## _baseSecondsToHhmm(secs)

Formats some amount of seconds in "hh:mm" with a variable separator `sep` and
suffix `suffix`.

### Params:

* **Number** *secs* The amount of seconds to format
* **String** *sep* A separator
* **String** *suffix* A suffix

### Return:

* **String**

## _leftPad(val, size, ch)

Pads a value `val` to the left by `size` `ch` or `' '` characters.

### Params:

* **Mixed** *val* The value to pad
* **Number** *size* The padding's size
* **String** *[ch=' ']* The padding character

### Return:

* **String** The padding result

# Documentation generation
Documentation was partially generated with `markdox` with smaller tweaks over
the generated markdown file.

You can reproduce it running `npm run cc && markdox lib/index.js`, which should
generate a mostly correct documentation, depending on how lucky we are about
where the coffee-script compiler puts our comments.

# Code coverage generation
`npm run coverage` runs tests and generates an HTML code-coverage report.

