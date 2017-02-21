//
//  MarkDown.swift
//  Xcode Helpers
//
//  Created by Jeff on 2/20/17.
//  Copyright © 2017 Jeff Small. All rights reserved.
//

import Foundation
import XcodeKit

enum CommandIdentifier: String {
    case backtickSelection = "BacktickSelection"
    case camelCaseLower = "LowerCamelCase"
    case camelCaseUpper = "UpperCamelCase"
}

class MarkDown: NSObject, XCSourceEditorCommand {

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.

        /// Regardless whether or not this actually worked,
        /// run the completion handler with no error.
        defer {
            completionHandler (nil)
        }

        guard let selection = LineSelection(from: invocation),
            let commandIdentifier = invocation.commandIdentifier.components(separatedBy: ".").last else
        {
            return
        }

        switch commandIdentifier {
        case CommandIdentifier.backtickSelection.rawValue:
            backTickSelection(selection: selection, invocation: invocation)
        default:
            print("Couldn't find a command with the identifier: \(commandIdentifier).")
            break
        }
    }

    func backTickSelection(selection: LineSelection, invocation: XCSourceEditorCommandInvocation) {
        // Replace the text on the selected line with a `` surrounded string.
        let trimmedHighlightedText = selection.highlightedText.trimmingCharacters(in: .whitespaces).backTicked()
        if let rangeOfTextToChange = selection.rangeOfHighlightedText {
            let replacementLine = selection.fullLineText.replacingCharacters(in: rangeOfTextToChange,
                                                                             with: trimmedHighlightedText)
            invocation.buffer.lines[selection.start.line] = replacementLine
        }
    }
}

