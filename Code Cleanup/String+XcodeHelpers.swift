//
//  CamelCase.swift
//  Xcode Helpers
//
//  Created by Jeff on 2/20/17.
//  Copyright © 2017 Jeff Small. All rights reserved.
//

import Foundation

extension String {

    /// - Returns: A copy of the current string with the first letter capitalized.
    func firstLetterCapitalized() ->  String {
        // Make the first letter lowercase
         let firstLetter =  String(characters.prefix(1)).uppercased()
         let otherLetters = String(characters.dropFirst())
         return firstLetter + otherLetters
    }

    /// Creates a copy of the current string with all of the spaces removed,
    /// and the beginning of each word capitalized.
    ///
    /// - Parameter upper:  `true` if the first letter should be capitalized, `false` otherwise.
    /// - Returns:  A camel-cased copy of the original string
    func camelCased( upper: Bool = false) ->  String {
        let words = components(separatedBy:  " ")
        
        var correctedWord = ""
        for (index, word) in words.enumerated() {
            if index == 0 {
                correctedWord +=  upper ? word.firstLetterCapitalized() : word.lowercased()
                continue
            }
            
            correctedWord += word.firstLetterCapitalized()
        }
        
        return correctedWord
    }

    func backTicked() -> String {
        return "`\(self)`"
    }
}
