//
//  Utilities.swift
//  Xcode Helpers
//
//  Created by Jeff on 2/20/17.
//  Copyright © 2017 Jeff Small. All rights reserved.
//

import XcodeKit

struct Position {
    let line: Int
    let column: Int
}

struct LineSelection {
    let start: Position
    let end: Position
    let rangeOfHighlightedText: Range<String.Index>?
    let fullLineText: String
    let highlightedText: String

    init?(from invocation: XCSourceEditorCommandInvocation) {
        guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange,
            let fullLineText = invocation.buffer.lines[selection.start.line] as? String else
        {
            print("There were no selections.")
            return nil
        }

        self.fullLineText = fullLineText
        start = Position(line: selection.start.line, column: selection.start.column)
        end = Position(line: selection.start.line,  column: selection.end.column)

        // Get the highlighted text
        let distanceFromEndOfLineToEndOfSelection = fullLineText.characters.count - selection.end.column
        let prefixChoppedOff = String(fullLineText.characters.dropFirst(selection.start.column))
        highlightedText = String(prefixChoppedOff.characters.dropLast(distanceFromEndOfLineToEndOfSelection))

        // Find the range
        rangeOfHighlightedText = fullLineText.range(of: highlightedText)
    }
}
