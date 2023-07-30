//
//  ForgotPasswordViewModel.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by Administrator on 13/07/23.
//

import Foundation
import Combine
enum RequestError:Error{
    case forgotPasswordFailed
}
class ForgotPasswordViewModel:ObservableObject{
    var showActivity = PassthroughSubject<Bool, Never>()
    var emailSubject = PassthroughSubject<String, Error>()
    var submitSubject = PassthroughSubject<Bool, Error>()
    var submitResult = PassthroughSubject<String,Never>()
    
    var cancellable = Set<AnyCancellable>()
    
    let useCase: ForgotPasswordUseCase
    
    init(useCaseFP:ForgotPasswordUseCase = ForgotPasswordUseCase()){
        self.useCase = useCaseFP
        
        
        submitSubject
            .combineLatest(emailSubject)
            .sink(receiveCompletion: {[weak self] completion in
                self?.submitResult.send("Forgot password failure.")
            },
            receiveValue: {[weak self] (doSubmit, email) in
                
                self?.showActivity.send(true)
                self?.useCase.execute(email: email, completion: {[weak self] val in
                    self?.showActivity.send(false)
//                    val ? self?.submitSubject.send(completion: .finished) : self?.submitSubject.send(completion: .failure(RequestError.forgotPasswordFailed))
                    val ?
                    self?.submitResult.send("Please check your email.") :
                    self?.submitResult.send("Forgot password failure.")
                    
                })
            })
            .store(in: &cancellable)
    }
    func cleanup(){
        showActivity.send(completion: .finished)
        emailSubject.send(completion: .finished)
        submitSubject.send(completion: .finished)
        submitResult.send(completion: .finished)
    }
}
