//
//  SignupCoordinator.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by Administrator on 13/07/23.
//

import Foundation
import UIKit

protocol SignupCoordinatorDelegate_Previous:AnyObject{
    func navigateBackToSignup()
}

class SignupCoordinator:Coordinator{
    var childCoordinators =  [Coordinator]()
    
    unowned let navigationController:UINavigationController
    weak var delegate:SignupCoordinatorDelegate_Previous?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let sb = UIStoryboard(name: "Auth", bundle: nil)
        let signupVc = sb.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        signupVc.coordinator = self
        self.navigationController.pushViewController(signupVc, animated: true)
    }
    
    
}
extension SignupCoordinator:SignupViewDelegate{
    func goBack() {
        delegate?.navigateBackToSignup()
    }
    
    
}
