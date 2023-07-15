//
//  LoginCoordinator.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by Administrator on 13/07/23.
//

import Foundation
import UIKit

class LoginCoordinator:Coordinator  {
    var childCoordinators: [Coordinator] = []
    

    unowned let navigationController:UINavigationController
  

    required init(navigationController:UINavigationController){
        self.navigationController = navigationController
    }

    func start(){
        let sb = UIStoryboard(name: "Auth", bundle: nil)
        let loginVC = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginVC.delegate = self
        self.navigationController.viewControllers = [loginVC]
    }
}
extension LoginCoordinator:LoginViewDelegate{
    func navigateToSignup() {
        let signupCoordinator = SignupCoordinator(navigationController: self.navigationController)
        signupCoordinator.delegate = self
        self.childCoordinators.append(signupCoordinator)
        signupCoordinator.start()
    }
    
    func navigateToForgotPassword() {
        let forgotCoordinator = ForgotPasswordCoordinator(navigationController: self.navigationController)
        forgotCoordinator.delegate = self
        self.childCoordinators.append(forgotCoordinator)
        forgotCoordinator.start()
    }
    
    
}
extension LoginCoordinator:SignupCoordinatorDelegate_Previous{
   
    func navigateBackToSignup(){
        self.childCoordinators.removeLast()
        self.navigationController.popViewController(animated: true)
    }
}
extension LoginCoordinator:ForgotPasswordCoordinator_Previous{
    func navigateToPrevious() {
        self.childCoordinators.removeLast()
        self.navigationController.popViewController(animated: true)
    }
}
