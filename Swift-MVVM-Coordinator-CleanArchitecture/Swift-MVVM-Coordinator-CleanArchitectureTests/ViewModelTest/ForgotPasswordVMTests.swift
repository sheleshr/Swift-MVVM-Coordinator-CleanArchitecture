//
//  ForgotPasswordVMTests.swift
//  Swift-MVVM-Coordinator-CleanArchitectureTests
//
//  Created by t0175Z7 on 26/07/23.
//

import XCTest
@testable import Swift_MVVM_Coordinator_CleanArchitecture
import Combine

final class ForgotPasswordVMTests: XCTestCase {

    var subscriptions = Set<AnyCancellable>()
    
    func testSubmitEmailSuccess(){
        let vm = ForgotPasswordViewModel(useCaseFP:
                                            ForgotPasswordUseCase(forgotPasswordRepo:
                                                                        MockForgotPasswordStore()))
        let expectation_submitResult = self.expectation(description: "expectation.submitResult_success")
        
        vm.submitResult
            .sink {[weak self] responseStr in
                XCTAssertNotNil(responseStr)
                XCTAssertEqual(responseStr, "Please check your email.")
                expectation_submitResult.fulfill()
                self?.subscriptions = Set<AnyCancellable>()
            }
            .store(in: &subscriptions)
       
        vm.emailSubject.send("tst@test.com")
        vm.submitSubject.send(true)
        waitForExpectations(timeout: 1)
    }
    func testSubmitEmailFailure(){
        let vm = ForgotPasswordViewModel(useCaseFP:
                                            ForgotPasswordUseCase(forgotPasswordRepo:
                                                                        MockForgotPasswordStore()))
        let expectation_submitResult = self.expectation(description: "expectation.submitResult_failure")
        
        vm.submitResult
            .sink {[weak self] responseStr in
                XCTAssertNotNil(responseStr)
                XCTAssertEqual(responseStr, "Forgot password failure.")
                expectation_submitResult.fulfill()
                self?.subscriptions = Set<AnyCancellable>()
            }
            .store(in: &subscriptions)
       
        vm.emailSubject.send("")
        vm.submitSubject.send(true)
        waitForExpectations(timeout: 1)
    }
    func testFinishedEmailSubject() throws{
        let vm = ForgotPasswordViewModel(useCaseFP:
                                            ForgotPasswordUseCase(forgotPasswordRepo:
                                                                        MockForgotPasswordStore()))
        
        
        let expectation_cleanup = self.expectation(description: "expectation.cleanup")
        
        vm.emailSubject.sink(receiveCompletion: {[weak self] completion in
            switch completion{
            case .finished:
                XCTAssertTrue(true)
            case .failure(_):
                XCTAssertTrue(false)
            }
            expectation_cleanup.fulfill()
            self?.subscriptions = Set<AnyCancellable>()
            
        }, receiveValue: { responseStr in
//            XCTAssertNil(responseStr)
//            self?.subscriptions = Set<AnyCancellable>()
        })
            .store(in: &subscriptions)
       
        
        vm.emailSubject.send(completion: .finished)
        
        waitForExpectations(timeout: 1)

    }
    func testFinishedSubmitSubject() throws{
        let vm = ForgotPasswordViewModel(useCaseFP:
                                            ForgotPasswordUseCase(forgotPasswordRepo:
                                                                        MockForgotPasswordStore()))
        
        
        let expectation_submitSubject = self.expectation(description: "expectation.cleanup.submitSub")
        
       
        vm.submitSubject
            .sink(receiveCompletion: {[weak self] completion in
                switch completion{
                case .finished:
                    XCTAssertTrue(true)
                case .failure(_):
                    XCTAssertTrue(false)
                }
                expectation_submitSubject.fulfill()
                self?.subscriptions = Set<AnyCancellable>()
                
            }, receiveValue: { val in
//                XCTAssertNil(val)
//                self?.subscriptions = Set<AnyCancellable>()
            })
            .store(in: &subscriptions)
       
        
        vm.submitSubject.send(completion: .finished)
       
        waitForExpectations(timeout: 1)

    }
    func testFinishedSubmitResult() throws{
        let vm = ForgotPasswordViewModel(useCaseFP:
                                            ForgotPasswordUseCase(forgotPasswordRepo:
                                                                        MockForgotPasswordStore()))
        
        
        let expectation_submitResult = self.expectation(description: "expectation.cleanup.submitResult")
        
        vm.submitResult
            .sink { completion in
                switch completion{
                case .finished:
                    XCTAssertTrue(true)
                case .failure(_):
                    XCTAssertTrue(false)
                }
                expectation_submitResult.fulfill()
                self.subscriptions = Set<AnyCancellable>()
            } receiveValue: { resultString in
//                XCTAssertNil(resultString)
//                self.subscriptions = Set<AnyCancellable>()
            }
            .store(in: &subscriptions)
   
        vm.submitResult.send(completion: .finished)
        
        waitForExpectations(timeout: 1)

    }
    func testCleanup() throws{
        let vm = ForgotPasswordViewModel(useCaseFP:
                                            ForgotPasswordUseCase(forgotPasswordRepo:
                                                                        MockForgotPasswordStore()))
        
        
        let expectation_cleanup = self.expectation(description: "expectation.cleanup")
        
        vm.emailSubject.sink(receiveCompletion: {[weak self] completion in
            switch completion{
            case .finished:
                XCTAssertTrue(true)
            case .failure(_):
                XCTAssertTrue(false)
            }
            expectation_cleanup.fulfill()
            self?.subscriptions = Set<AnyCancellable>()
            
        }, receiveValue: { responseStr in
//            XCTAssertNil(responseStr)
//            self?.subscriptions = Set<AnyCancellable>()
        })
            .store(in: &subscriptions)
       
        
        vm.cleanup()
        
        waitForExpectations(timeout: 1)

    }
}

