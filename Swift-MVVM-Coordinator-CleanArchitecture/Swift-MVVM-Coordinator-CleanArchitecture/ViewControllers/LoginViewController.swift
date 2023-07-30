//
//  LoginViewController.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by Administrator on 13/07/23.
//

import UIKit
import Combine

protocol LoginViewDelegate:AnyObject {
    func navigateToSignup()
    func navigateToForgotPassword()
    func naviationToHome()
}


class LoginViewController: UIViewController {

    @IBOutlet weak var txtFdUsername: UITextField!
    @IBOutlet weak var txtFdPassword: UITextField!
    
    weak var delegate:LoginViewDelegate?
    var vm = LoginViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    var signinTask:Task<Void,Never>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindUI()
    }
    func bindUI(){
        txtFdUsername.publisher(for: \.text)
            .sink {[weak self] text in
                self?.vm.username = text ?? ""
            }
            .store(in: &subscriptions)
        
        txtFdPassword.publisher(for: \.text)
            .sink {[weak self] text in
                self?.vm.password = text ?? ""
            }
            .store(in: &subscriptions)
    }
    @IBAction func signinAction(_ sender: Any) {
        txtFdUsername.resignFirstResponder()
        txtFdPassword.resignFirstResponder()
        self.signinTask = Task{
            let result = await vm.signin()
            switch result{
            case .success(let val):
                val ?
                delegate?.naviationToHome() :
                print(">> Login has some issue.")
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    @IBAction func signupAction(_ sender: Any) {
        delegate?.navigateToSignup()
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        delegate?.navigateToForgotPassword()
    }
    
    deinit{
        signinTask?.cancel()
    }
    
}
