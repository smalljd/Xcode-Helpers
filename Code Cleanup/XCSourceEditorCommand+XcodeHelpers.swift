//
//  XCSourceEditorCommand+XcodeHelpers.swift
//  Xcode Helpers
//
//  Created by Jeff on 2/20/17.
//  Copyright © 2017 Jeff Small. All rights reserved.
//

import XcodeKit

extension XCSourceEditorCommand {

    /// Updates the selected text buffer in the source editor.
    ///
    /// - Parameters:
    ///   - invocation:  The invocation that was used to execute this command
    ///   - start:  The desired start position of the new text selection
    ///   - end: The desired end position of the new text selection 
    func updateHighlightedText(invocation: XCSourceEditorCommandInvocation,
                               start: Position,
                               end: Position)
    {
        let newSelectionBuffer = XCSourceTextRange(start: XCSourceTextPosition(line: start.line,
                                                                               column: start.column),
                                                   end: XCSourceTextPosition(line: end.line,
                                                                             column: end.column))
        invocation.buffer.selections.setArray([newSelectionBuffer])
    }
}
