//
//  ForgotPasswordViewController.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by Administrator on 13/07/23.
//

import UIKit
import Combine

protocol ForgotPasswordViewDelegate:AnyObject{
    func goBack()
    func showAlert(title:String, message:String)
}

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtFdEmail: UITextField!
    weak var coordinator:ForgotPasswordViewDelegate?
    let vm = ForgotPasswordViewModel()
    
    var cancellable = Set<AnyCancellable>()
    
    var activityIndicator:UIActivityIndicatorView?
//    = {
//        let activity = UIActivityIndicatorView(style: .large)
//        activity.color = .orange
//        activity.hidesWhenStopped = true
//        activity.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(activity)
//
//        NSLayoutConstraint.activate([
//            activity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            activity.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
//        ])
//
//        return activity
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .orange
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activity)
        
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        self.activityIndicator = activity
        
        
        bindViews()
        // Do any additional setup after loading the view. self.txtFdEmail.addTarget(self, action: #emailDidEndEditing, for: .re)
    }
    
    private func bindViews(){
        vm.showActivity
            .receive(on: DispatchQueue.main)
            .sink {[weak self] show in
                if show {
                    self?.activityIndicator?.startAnimating()
                }else{
                    self?.activityIndicator?.stopAnimating()
                }
            }
            .store(in: &cancellable)
        
        
        self.txtFdEmail.publisher(for: \.text)
            .dropFirst()
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] txt in
                self?.vm.emailSubject.send(self?.txtFdEmail.text ?? "")
                
            }
            .store(in: &cancellable)
        
//        self.vm.submitSubject
//            .receive(on: DispatchQueue.main)
//            .sink {[weak self] completion in
//            switch completion{
//            case .finished:
//                self?.coordinator?.goBack()
//            case .failure(let er):
//                print(er.localizedDescription)
//                self?.coordinator?.goBack()
//            }
//        } receiveValue:{_ in
//            
//        }.store(in: &cancellable)

        self.vm.submitResult
            .receive(on: DispatchQueue.main)
            .sink {[weak self] responseStr in
                self?.coordinator?.showAlert(title: "Forgot Password", message: responseStr)
            }
            .store(in: &cancellable)
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        vm.cleanup()
        coordinator?.goBack()
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
        self.txtFdEmail.endEditing(true)
        
        self.vm.submitSubject.send(true)
        
//        DispatchQueue.global().asyncAfter(wallDeadline: .now()+1, execute: {
//            self.vm.submit {[weak self] val in
//                DispatchQueue.main.async {
//                    print(val ? "Email sent successfully." : "Something went wrong.")
//                    if val{
//                        self?.coordinator?.goBack()
//                    }
//                }
//            }
//        })
        

    }
}
extension ForgotPasswordViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}
