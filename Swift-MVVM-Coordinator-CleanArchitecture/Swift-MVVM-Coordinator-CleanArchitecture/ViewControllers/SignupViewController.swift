//
//  SignupViewController.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by Administrator on 13/07/23.
//

import UIKit
protocol SignupViewDelegate:AnyObject{
    func goBack()
}
class SignupViewController: UIViewController {

    weak var coordinator:SignupViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        coordinator?.goBack()
    }
    
}
