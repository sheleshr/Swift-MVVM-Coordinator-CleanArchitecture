//
//  HomeVMTests.swift
//  Swift-MVVM-Coordinator-CleanArchitectureTests
//
//  Created by t0175Z7 on 28/07/23.
//

import XCTest
@testable import Swift_MVVM_Coordinator_CleanArchitecture

final class HomeVMTests: XCTestCase {

    func testLogout()async{
        let vm = HomeViewModel()
        let result = await vm.logout()
        
        switch result {
        case .success(let val):
            XCTAssertTrue(val)
        case .failure(let err):
            XCTAssertNil(err)
        }
    }
}
