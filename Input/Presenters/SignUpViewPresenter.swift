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
}

class SignUpViewPresenter: BaseViewPresenter, SignUpViewPresenterProtocol {
    
    private var view: SignUpViewControllerProtocol
    
    required init(view: SignUpViewControllerProtocol) {
        self.view = view
    }
    
    func onTapSubmit(email: String, confirmEmail: String, password: String) {
        if !email.isValidatedEmail() {
            view.showAlertMessage(msg: String.localizeFrom(key: "email_invalid"))
        } else if email != confirmEmail {
            view.showAlertMessage(msg: String.localizeFrom(key: "confirm_email_invalid"))
        } else if !password.isValidatedPassword() {
            view.showAlertMessage(msg: String.localizeFrom(key: "password_invalid"))
        } else {
            view.showAlertMessage(msg: String.localizeFrom(key: "signup_success"))
        }
    }
}
