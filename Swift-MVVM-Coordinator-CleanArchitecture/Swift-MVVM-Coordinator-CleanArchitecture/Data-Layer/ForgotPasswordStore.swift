//
//  ForgotPasswordStore.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by Administrator on 13/07/23.
//

import Foundation
import Combine
protocol ForgotPasswordStoreInterface {
    func submitForgotPassword(email:String) -> AnyPublisher<Bool, Never>
}

class ForgotPasswordStore: ForgotPasswordStoreInterface {
    func submitForgotPassword(email: String) -> AnyPublisher<Bool, Never> {
        print("RECEIVE EMAIL:",email)
        return Future {[weak self] promis in
            //self?.showActivity.send(true)
            DispatchQueue.global().asyncAfter(wallDeadline: .now()+3) {
                //self?.showActivity.send(false)
                promis(.success(true))
                
            }
        }
        .eraseToAnyPublisher()
    }
    
    
}


