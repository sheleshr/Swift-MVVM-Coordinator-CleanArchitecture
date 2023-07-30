//
//  MockForgotPasswordStore.swift
//  Swift-MVVM-Coordinator-CleanArchitectureTests
//
//  Created by t0175Z7 on 26/07/23.
//

import Foundation
import Combine
@testable import Swift_MVVM_Coordinator_CleanArchitecture

class MockForgotPasswordStore:ForgotPasswordStoreInterface{
    func submitForgotPassword(email: String) -> AnyPublisher<Bool, Never> {
        let pub = CurrentValueSubject<String,Never>(email)
            .map { $0.count > 0 ?
                true :
                false
            }
            .eraseToAnyPublisher()
        
        return pub
    }
    
    
}

