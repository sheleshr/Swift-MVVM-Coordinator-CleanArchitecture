//
//  LoginVMTests.swift
//  Swift-MVVM-Coordinator-CleanArchitectureTests
//
//  Created by t0175Z7 on 28/07/23.
//

import XCTest
@testable import Swift_MVVM_Coordinator_CleanArchitecture

final class LoginVMTests: XCTestCase {

    func testSigninTest()async {
        let vm = LoginViewModel()
        vm.username = ""
        vm.password = ""
        let result = await vm.signin()
        
        switch result {
        case .success(let val):
            XCTAssertTrue(val)
        case .failure(let err):
            XCTAssertNil(err)
        }
    }
}
