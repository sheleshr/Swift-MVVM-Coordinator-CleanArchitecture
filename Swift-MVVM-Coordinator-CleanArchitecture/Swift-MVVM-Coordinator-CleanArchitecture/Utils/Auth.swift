//
//  Auth.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by t0175Z7 on 28/07/23.
//

import Foundation
import Combine

class Auth:ObservableObject{
    static var shared = Auth()
    
    @Published var isAuthenticated = false
    
    private init() {

    }
    func logout() async -> Result<Bool,Error>{
        //isAuthenticated = false
        return .success(true)
    }
    func login(username:String, password:String) async -> Result<Bool,Error>{
        //isAuthenticated = true
        return .success(true)
    }
}
