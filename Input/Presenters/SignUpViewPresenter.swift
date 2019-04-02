//
//  SignUpViewPresenter.swift
//  Input
//
//  Created by IVC on 3/29/19.
//  Copyright © 2019 jz. All rights reserved.
//

import UIKit

protocol SignUpViewPresenterProtocol: BaseViewPresenterProtocol {
    init(view: SignUpViewControllerProtocol)
    func onTapSubmit(email: String, confirmEmail: String, password: String)
    func getEntity() -> SignUpEntity
}

class SignUpViewPresenter: BaseViewPresenter, SignUpViewPresenterProtocol {
    
    private var view: SignUpViewControllerProtocol
    private var model: SignUpModelProtocol
    private var entity: SignUpEntity?
    
    required init(view: SignUpViewControllerProtocol) {
        self.view = view
        model = SignUpModel.shared
    }
    
    func viewWillAppear() {
        model.addObserverSignUpRequest(self, selector: #selector(signUpFinish))
    }
    
    func onTapSubmit(email: String, confirmEmail: String, password: String) {
        if !email.isValidatedEmail() {
            view.showAlertMessage(msg: String.localizeFrom(key: "email_invalid"))
        } else if email != confirmEmail {
            view.showAlertMessage(msg: String.localizeFrom(key: "confirm_email_invalid"))
        } else if !password.isValidatedPassword() {
            view.showAlertMessage(msg: String.localizeFrom(key: "password_invalid"))
        } else {
            view.showIndicator()
            model.fetchSignUpRequest(email: email, password: password)
        }
    }
    
    @objc private func signUpFinish() {
        view.hideIndicator()
        view.update()
    }
    
    func getEntity() -> SignUpEntity {
        return model.entity
    }
    
    func viewWillDisAppear() {
        model.removeObserver(self)
    }
}
