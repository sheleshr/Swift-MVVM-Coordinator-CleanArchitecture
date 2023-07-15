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
    var useCase = ForgotPasswordUseCase()
    var cancellable = Set<AnyCancellable>()
    init(){
        submitSubject
            .combineLatest(emailSubject)
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: {[weak self] (doSubmit, email) in
                
                self?.showActivity.send(true)
                self?.useCase.execute(email: email, completion: {[weak self] val in
                    self?.showActivity.send(false)
                    val ? self?.submitSubject.send(completion: .finished) : self?.submitSubject.send(completion: .failure(RequestError.forgotPasswordFailed))
                    
                })
            })
            .store(in: &cancellable)
    }
    
}
