//
//  HomeViewController.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by t0175Z7 on 28/07/23.
//

import Foundation
import UIKit
protocol HomeViewDelegate:AnyObject{
    func logout()
}

class HomeViewController:UIViewController{
    
    weak var delegate:HomeViewDelegate?
    let vm = HomeViewModel()
    var taskLogout:Task<Void,Never>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        taskLogout = Task{
            let result = await vm.logout()
            switch result {
            case .success(let val):
                if val == true {
                    DispatchQueue.main.async {
                        self.delegate?.logout()
                    }
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        taskLogout?.cancel()
    }
}
