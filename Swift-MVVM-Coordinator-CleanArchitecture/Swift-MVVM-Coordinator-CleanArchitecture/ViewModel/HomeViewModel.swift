//
//  HomeViewModel.swift
//  Swift-MVVM-Coordinator-CleanArchitecture
//
//  Created by t0175Z7 on 28/07/23.
//

import Foundation

class HomeViewModel:ObservableObject{
    
    func logout()async -> Result<Bool,Error>{
        let result = await Auth.shared.logout()
        return result
    }
}
