//
//  ForbiddenActionTextfield.swift
//  Input
//
//  Created by IVC on 3/27/19.
//  Copyright © 2019 jz. All rights reserved.
//

import UIKit

class ForbiddenActionTextfield: UITextField {

    ///  Check PerformAction: true: set action PerformAction, false: disable PerformAction
    var isActionsEnabled = true {
        didSet {
            reloadInputViews()
        }
    }
    
    /// overide to hide any action menu in textfield when long touch at textfield
    ///
    /// - Parameters:
    ///   - action: Selector
    ///   - sender: Any
    /// - Returns: always false cause it will not show any action menu
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if !isActionsEnabled {
            return false
        }
        //Get overcome max length of line = 300
        var isCanPerformAction = action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.paste(_:))
        isCanPerformAction = isCanPerformAction || action == #selector(UIResponderStandardEditActions.select(_:)) || action == #selector(UIResponderStandardEditActions.selectAll(_:)) || action == #selector(UIResponderStandardEditActions.cut(_:))
        return  isCanPerformAction
    }
    
    /// Check  SecureText: if true and isFirstResponder is call becomeFirstResponder() else false, do nothing
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }
    /// override func becomeFirstResponder
    ///
    /// - Returns: true if this object is now the first-responder or false if it is not.
    override func becomeFirstResponder() -> Bool {
        guard super.becomeFirstResponder() else { return false }
        guard self.isSecureTextEntry == true else { return true }
        guard let existingText = self.text else { return true }
        self.text?.removeAll() //triggers a delete of all text
        self.insertText(existingText) // does not call delegates
        return true
    }

}
