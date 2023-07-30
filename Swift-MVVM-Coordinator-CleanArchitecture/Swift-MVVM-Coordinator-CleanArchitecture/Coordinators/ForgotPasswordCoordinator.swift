//
//  ForgotPasswordCoordinator.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by Administrator on 13/07/23.
//

import Foundation
import UIKit

protocol ForgotPasswordCoordinator_Previous:AnyObject{
    func navigateToPrevious()
    
}


class ForgotPasswordCoordinator:Coordinator{
    var childCoordinators = [Coordinator]()
    
    unowned let navigationController:UINavigationController
    weak var delegate:ForgotPasswordCoordinator_Previous?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let sb = UIStoryboard(name: "Auth", bundle: nil)
        let forgotVC = sb.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        forgotVC.coordinator = self
        self.navigationController.pushViewController(forgotVC, animated: true)
    }
    
    
}
extension ForgotPasswordCoordinator:ForgotPasswordViewDelegate{
    func goBack() {
        delegate?.navigateToPrevious()
    }
    
    func showAlert(title: String, message: String) {
        let alertCoordinator = AlertCoordinator(rootVC: self.navigationController, title: title, message: message)
        alertCoordinator.delegate = self
        self.childCoordinators.append(alertCoordinator)
        alertCoordinator.start()
    }
}
extension ForgotPasswordCoordinator:AlertCoordinatorActionDelegate{
    func hideAlert() {
        self.goBack()
    }
    
    
}
