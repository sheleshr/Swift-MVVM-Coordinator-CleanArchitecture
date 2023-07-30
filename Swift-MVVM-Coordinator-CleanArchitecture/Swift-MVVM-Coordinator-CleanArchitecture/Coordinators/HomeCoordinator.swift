//
//  RootCoordinator.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by t0175Z7 on 28/07/23.
//

import Foundation
import UIKit

class HomeCoordinator:Coordinator{
    var childCoordinators:[Coordinator] = []
    
    unowned let navigationController:UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let sb = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = sb.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        homeVC.delegate = self
        self.navigationController.viewControllers = [homeVC]
    }
    
    
}
extension HomeCoordinator:HomeViewDelegate{
    func logout() {
        childCoordinators = []
        Auth.shared.isAuthenticated = false
        navigationController.viewControllers = []
        
    }

}
