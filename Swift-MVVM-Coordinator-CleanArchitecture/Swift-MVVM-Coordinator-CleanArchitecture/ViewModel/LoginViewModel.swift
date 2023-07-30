//
//  LoginViewModel.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by Administrator on 13/07/23.
//

import Foundation

class LoginViewModel:ObservableObject{
    @Published var username:String
    @Published var password:String
    
    init(username: String = "", password: String = "") {
        self.username = username
        self.password = password
    }
    func signin()async ->Result<Bool,Error>{
        let result = await Auth.shared.login(username: username, password: password)
        return result
    }
}
