# StringTruncation
Adds Regex string truncation as a String Extension

`String.truncate()` returns a truncated string, of `maxLength`, truncated before the last instance matching `regularExpression` and replaced with `filler` text.

*Example*
let string = "Hello this is a long string (by: Me)"
let truncated = string.truncate(forMaxLength:16, filler:">>")

Here, `truncated` will be "Hello >>(by: Me)"
