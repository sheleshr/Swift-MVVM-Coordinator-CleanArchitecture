//
//  ForgotPasswordUseCase.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by Administrator on 13/07/23.
//

import Foundation
import Combine
class ForgotPasswordUseCase {
    
    private var forgotPasswordRepo =  ForgotPasswordStore()
    var cancellable:AnyCancellable?
    
    func execute(email:String,completion:@escaping (Bool) -> Void) {
       cancellable = forgotPasswordRepo.submitForgotPassword(email: email)
            .sink { val in
            completion(true)
        }
    }
}

