//
//  SignUpModel.swift
//  Input
//
//  Created by IVC on 3/29/19.
//  Copyright © 2019 jz. All rights reserved.
//

import UIKit

protocol SignUpNotify: class {
    func addObserverSignUpRequest(_ observer: Any, selector: Selector)
    func removeObserver(_ observer: Any)
}

protocol SignUpModelProtocol: SignUpNotify {
    var entity: SignUpEntity { get }
    func clear()
    func fetchSignRequest(email: String, password: String)
}

class SignUpModel: BaseModel, SignUpModelProtocol {
    
    static let shared: SignUpModelProtocol = SignUpModel()
    
    private override init() {
        // Init
    }
    
    var entity: SignUpEntity
    
    func clear() {
        entity = SignUpEntity()
    }
    
    func fetchSignRequest(email: String, password: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 200) {
            
        }
    }
    
    func addObserverSignUpRequest(_ observer: Any, selector: Selector) {
        <#code#>
    }
    
    func removeObserver(_ observer: Any) {
        <#code#>
    }
    
}
