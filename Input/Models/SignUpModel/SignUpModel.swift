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
    func fetchSignUpRequest(email: String, password: String)
}

class SignUpModel: BaseModel, SignUpModelProtocol {
    
    static let shared: SignUpModelProtocol = SignUpModel()
    
    private override init () {
        self.entity = SignUpEntity()
    }
    
    var entity: SignUpEntity
    
    func clear() {
        entity = SignUpEntity()
    }
    
    func fetchSignUpRequest(email: String, password: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.entity.isSuccess = true
            self.notifiSignUpFinish()
        }
    }
    
    func addObserverSignUpRequest(_ observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: .signUpObserverName, object: nil)
    }
    
    func removeObserver(_ observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
    
    private func notifiSignUpFinish() {
        NotificationCenter.default.post(name: .signUpObserverName, object: nil)
    }
    
}

extension Notification.Name {
    static let signUpObserverName = Notification.Name("signUpOberverName")
}
