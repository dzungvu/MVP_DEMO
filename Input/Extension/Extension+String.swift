//
//  Extension+String.swift
//  Input
//
//  Created by IVC on 3/27/19.
//  Copyright © 2019 jz. All rights reserved.
//

import Foundation

extension String {
    
    static let regularExpressionOfNotAlphabetAndNumberAndSymbol = "[^a-zA-Z0-9!\"#$%&'()¥*¥+¥-¥.,¥/:;<=>?@¥[¥\\¥]^_`{|}~]"
    static let regularExpressionOfPasswordNotAlphabetAndNumberAndSymbol = "[^a-zA-Z0-9!#$%()*+-.,/:;<=>?@_`{|}~\\[\\]^]"
    
    var trimToAlphabetAndNumberAndSymbolOnly: String {
        let reg = String.regularExpressionOfNotAlphabetAndNumberAndSymbol
        return self.trim(byRegularExpression: reg)
    }
    
    var trimToAlphabetAndNumberAndSymbolPasswordOnly: String {
        let reg = String.regularExpressionOfPasswordNotAlphabetAndNumberAndSymbol
        return self.trim(byRegularExpression: reg)
    }
    
    func trim(byRegularExpression reg: String) -> String {
        return self.replacingOccurrences(of: reg, with: "", options: .regularExpression, range: self.range(of: self))
    }
    
    func isTextInputEmpty() -> Bool {
        return (self.isEmpty)
    }
    
    static func localizeFrom(key: String) -> String {
        
        #if DEBUG
        
        if key.hasPrefix( "MSG_") {
            return String(format: "%@(%@)", NSLocalizedString(key, comment: kEmptyString), key)
        }
        
        #endif
        
        return NSLocalizedString(key, comment: kEmptyString)
    }
    
    /// Check the string is email or not
    ///
    /// - Returns: true if is email
    func isValidatedEmail() -> Bool {
        let regex = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidatedPassword() -> Bool {
        let pattern = "^[a-zA-Z0-9!\"#$%&'()¥*¥+¥-¥.,¥/:;<=>?@¥[¥\\¥]^_`{|}~]+$"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let matches = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
        return !matches.isEmpty
    }
}
