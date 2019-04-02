//
//  ViewController.swift
//  Input
//
//  Created by IVC on 3/27/19.
//  Copyright © 2019 jz. All rights reserved.
//

import UIKit

protocol SignUpViewControllerProtocol: BaseViewControllerProtocol {
    func showIndicator()
    func hideIndicator()
}


class SignUpViewController: BaseViewController, SignUpViewControllerProtocol {
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfConfirmEmail: ForbiddenActionTextfield!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private var presenter: SignUpViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter = SignUpViewPresenter(view: self)
        
        initView()
    }
    
    private func initView() {
        indicator.isHidden = true
        btnSubmit.isEnabled = false
        
        tfEmail.keyboardType = .emailAddress
        tfConfirmEmail.keyboardType = .emailAddress
        tfPassword.keyboardType = .asciiCapable
        
        tfConfirmEmail.isActionsEnabled = false
        
        tfEmail.autocorrectionType = .no
        tfPassword.autocorrectionType = .no
        
        tfEmail.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickSubmit(_ sender: UIButton) {
        presenter?.onTapSubmit(email: tfEmail.text!, confirmEmail: tfConfirmEmail.text!, password: tfPassword.text!)
    }
    
    @IBAction func onTapOutside(_ sender: UITapGestureRecognizer) {
        tfPassword.endEditing(true)
        tfEmail.endEditing(true)
        tfConfirmEmail.endEditing(true)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        
        guard let checkText = textField.text else { return }
        var maxLength: Int = 0
        
        switch textField {
        case tfEmail:
            textField.text = checkText.trimToAlphabetAndNumberAndSymbolOnly
            maxLength = kEmailMaxLength
        case tfPassword:
            textField.text = checkText.trimToAlphabetAndNumberAndSymbolPasswordOnly
            maxLength = kPasswordMaxLength
        default:
            break
        }
        
        
        if textField.text?.count ?? 0 >= maxLength {
            textField.text = String(textField.text?.prefix(maxLength) ?? "")
        }
        
        setEnableButton()
    }
    
    private func setEnableButton() {
        btnSubmit.isEnabled = (!tfEmail.text!.isTextInputEmpty() && !tfConfirmEmail.text!.isTextInputEmpty() && !tfPassword.text!.isTextInputEmpty())
    }
    
    func showIndicator() {
        indicator.startAnimating()
        indicator.isHidden = false
    }
    
    func hideIndicator() {
        indicator.isHidden = true
        indicator.stopAnimating()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.viewWillDisAppear()
        super.viewWillDisappear(animated)
    }
}

