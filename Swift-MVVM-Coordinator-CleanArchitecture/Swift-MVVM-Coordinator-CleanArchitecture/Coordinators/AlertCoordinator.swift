//
//  AlertCoordinator.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by t0175Z7 on 26/07/23.
//

import Foundation
import UIKit

protocol AlertCoordinatorActionDelegate:AnyObject{
    func hideAlert()
}



class AlertCoordinator:Coordinator{
    var childCoordinators: [Coordinator] = []
    
    unowned let parentVC:UINavigationController
    var titleStr:String
    var messageStr:String
    
    weak var delegate:AlertCoordinatorActionDelegate?
    
    required init(navigationController: UINavigationController) {
        self.parentVC = navigationController
        titleStr = ""
        messageStr = ""
    }
    convenience init(rootVC:UINavigationController,title:String, message:String){
        self.init(navigationController:rootVC)
        self.titleStr = title
        self.messageStr = message
    }
    func start() {
        let alertVC = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default) {[weak self] action in
            self?.delegate?.hideAlert()
        }
        alertVC.addAction(actionOK)
        parentVC.present(alertVC, animated: true)
    }
    
    
}
