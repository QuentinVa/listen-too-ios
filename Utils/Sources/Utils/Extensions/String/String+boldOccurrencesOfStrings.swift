//
//  String+boldOccurrencesOfStrings.swift
//
//
//  Created by Quentin Varlet on 19/12/2024.
//

import Foundation

extension String {

    public func boldOccurrencesOfString(of term: String) -> String {
        guard !self.isEmpty else { return self }

        return boldRanges(ranges: self.ranges(of: [term]))
    }

    public func boldOccurrencesOfStrings(of pattern: [String]) -> String {
        guard !self.isEmpty, !pattern.isEmpty else { return self }

        return boldRanges(ranges: self.ranges(of: pattern))
    }

    private func ranges(of searchStrings: [String]) -> [Range<String.Index>] {
        var ranges: [Range<String.Index>] = []

        // Find all ranges for each string in the array
        for searchString in searchStrings {
            var searchRange = self.startIndex..<self.endIndex
            while let foundRange = self.range(of: searchString, options: [.caseInsensitive, .diacriticInsensitive], range: searchRange) {
                ranges.append(foundRange)
                searchRange = foundRange.upperBound..<self.endIndex
            }
        }

        // Merge ranges if necessary
        ranges.sort { $0.lowerBound < $1.lowerBound }
        var mergedRanges: [Range<String.Index>] = []
        for range in ranges {
            if let lastRange = mergedRanges.last, lastRange.upperBound >= range.lowerBound {
                mergedRanges[mergedRanges.count - 1] = lastRange.lowerBound..<max(lastRange.upperBound, range.upperBound)
            } else {
                mergedRanges.append(range)
            }
        }

        return mergedRanges
    }

    private func boldRanges(ranges: [Range<String.Index>]) -> String {
        guard !ranges.isEmpty else { return self }

        // Use a buffer to store the final result
        var result = ""
        var lastIndex = self.startIndex

        for range in ranges {
            // Add the text before the found occurrence
            result += self[lastIndex..<range.lowerBound]

            // Handle special characters for Markdown
            var stringToReplace = String(self[range])
            var prefixString = ""
            while stringToReplace.isFirstCharacterSpecial {
                prefixString += String(stringToReplace.removeFirst())
            }
            var suffixString = ""
            while stringToReplace.isLastCharacterSpecial {
                suffixString = String(stringToReplace.removeLast()) + suffixString
            }

            // Add the occurrence in bold
            if !stringToReplace.isEmpty {
                result += "\(prefixString)**\(stringToReplace)**\(suffixString)"
            } else {
                result += "\(prefixString)\(suffixString)"
            }

            // Update the last index to continue the search
            lastIndex = range.upperBound
        }

        // Add the rest of the string after the last occurrence
        result += self[lastIndex..<self.endIndex]

        return result
    }
}
