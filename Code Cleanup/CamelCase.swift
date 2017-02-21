//
//  SourceEditorCommand.swift
//  Code Cleanup
//
//  Created by Jeff on 2/20/17.
//  Copyright © 2017 Jeff Small. All rights reserved.
//

import Foundation
import XcodeKit

class CamelCase: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        defer {
             completionHandler (nil)
        }
        
        // Capture the selection.
        guard let selection = LineSelection(from: invocation) else {
            return
        }

        // If the commandIdentifier == UpperCamelCase, capitalize the first letter and camel-case the rest.
        // Otherwise, lower camel-case the selection.
        let camelCasedSelection = invocation.commandIdentifier.contains("UpperCamelCase") ? selection.highlightedText.camelCased(upper: true) : selection.highlightedText.camelCased()

        // Update the selected lines with the new camel-cased word.
        if let rangeToChange =  selection.rangeOfHighlightedText {
            let newLine =  selection.fullLineText.replacingCharacters(in: rangeToChange, with: camelCasedSelection)
            invocation.buffer.lines[selection.start.line] = newLine
        }

        // Update the selection so that the newly camel-cased word is highlighted.
        let endColumnPosition = (invocation.buffer.lines[selection.start.line] as! String).characters.count - 1
        let newSelectionBuffer = XCSourceTextRange(start: XCSourceTextPosition(line: selection.start.line,
                                                                               column: selection.start.column),
                                                   end: XCSourceTextPosition(line: selection.start.line,
                                                                             column: endColumnPosition))

        invocation.buffer.selections.setArray([newSelectionBuffer])
    }
}
