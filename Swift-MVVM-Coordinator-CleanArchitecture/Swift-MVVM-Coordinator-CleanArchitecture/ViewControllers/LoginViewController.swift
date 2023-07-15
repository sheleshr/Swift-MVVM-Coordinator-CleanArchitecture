//
//  LoginViewController.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by Administrator on 13/07/23.
//

import UIKit
protocol LoginViewDelegate:AnyObject {
    func navigateToSignup()
    func navigateToForgotPassword()
}


class LoginViewController: UIViewController {

    @IBOutlet weak var txtFdUsername: UITextField!
    @IBOutlet weak var txtFdPassword: UITextField!
    
    weak var delegate:LoginViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signinAction(_ sender: Any) {
    }
    
    @IBAction func signupAction(_ sender: Any) {
        delegate?.navigateToSignup()
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        delegate?.navigateToForgotPassword()
    }
    
}
