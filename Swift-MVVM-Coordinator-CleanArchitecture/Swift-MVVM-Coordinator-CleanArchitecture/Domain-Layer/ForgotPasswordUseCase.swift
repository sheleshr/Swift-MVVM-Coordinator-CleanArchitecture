//
//  ForgotPasswordUseCase.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by Administrator on 13/07/23.
//

import Foundation
import Combine
class ForgotPasswordUseCase {
    
    let forgotPasswordRepo: ForgotPasswordStoreInterface
    var subscriptions = Set<AnyCancellable>()
    
    init(forgotPasswordRepo: ForgotPasswordStoreInterface = ForgotPasswordStore()) {
        self.forgotPasswordRepo = forgotPasswordRepo
        
    }
    func execute(email:String,completion:@escaping (Bool) -> Void) {
       forgotPasswordRepo.submitForgotPassword(email: email)
            .sink { val in
            completion(val)
        }
            .store(in: &subscriptions)
    }
    deinit{
        subscriptions.forEach { subscription in
            subscription.cancel()
        }
    }
}

