//
//  Truncation.swift
//  StringTruncation
//
//  Created by Chris Nielubowicz on 7/13/16.
//  Copyright © 2016 Chris Nielubowicz. All rights reserved.
//

import Foundation

extension String {
    // regEx should match any non-zero-length portion of a string contained within parentheses
    // e.g. "this is () not part (XXXXXXXXX) of the match (ZZZZZZZZ)" XXXX and ZZZZ will both be matches, but () will not
    static let defaultRegularExpression = try? NSRegularExpression(pattern: "\\([A-z:,+&/ ]{1,}\\)", options: NSRegularExpressionOptions.AnchorsMatchLines)
    func truncate(forMaxLength length: Int, with filler: String = "... ", for regularExpression: NSRegularExpression? = String.defaultRegularExpression) -> String {
        guard let regularExpression = regularExpression else { return self }
        var fullRange = (self as NSString).rangeOfString(self)
        
        var endingMatch = ""
        var matchRange: NSRange?
        let matches = regularExpression.matchesInString(self, options: NSMatchingOptions.ReportCompletion, range: fullRange)
        // take the last match of the regex to get the caption string
        // which hopefully is at the end of the string, enclosed in parenthesis
        if let captionMatch = matches.last {
            matchRange = captionMatch.rangeAtIndex(0)
            endingMatch = (self as NSString).substringWithRange(matchRange!)
        }
    
        var truncatedString = self
        if let matchRange = matchRange {
            // roll back the end of the range of the string by filler text + match length
            // i.e. the new truncated string from example will be "this is () not part (XXXXXXXXX) of the ma"
            if fullRange.length > (filler.characters.count + matchRange.length) {
                fullRange.length -= (filler.characters.count + matchRange.length)
            }
            
            // then truncate the length to the given maxLength, adjusted by filler + match length
            // i.e. given the example string, default filler, and a maxLength of 41, the length of truncated example (41) is still
            // longer than 41 - 4 - 10 [ (ZZZZZZZZ) length] = 27.
            // so the string will be further truncated down to 27 characters to allow for filler and caption
            fullRange.length = min(fullRange.length, length - (filler.characters.count + matchRange.length))
            fullRange.length = max(fullRange.length, 0)
            truncatedString = (self as NSString).substringWithRange(fullRange)
            truncatedString += filler
        }
        
        return truncatedString + endingMatch
    }
}
