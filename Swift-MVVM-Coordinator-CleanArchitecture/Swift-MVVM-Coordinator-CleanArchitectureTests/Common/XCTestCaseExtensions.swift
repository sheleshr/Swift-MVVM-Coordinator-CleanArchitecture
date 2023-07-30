//
//  XCTestCaseExtensions.swift
//  Swift-MVVM-Coordinator-CleanArchitectureTests
//
//  Created by t0175Z7 on 28/07/23.
//

import XCTest
import Combine
enum EmptyError:Error{
    case empty
    case ErrorAny(String)
}
extension XCTestCase {
    func awaitPublisher<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 2,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, EmptyError>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(.ErrorAny(error.localizedDescription))
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        
        waitForExpectations(timeout: timeout) { error in
            if let err = error {
                result = .failure(.ErrorAny(err.localizedDescription))
            }else{
                result = .failure(.empty)
            }
        }
        //waitForExpectations(timeout: timeout)
        cancellable.cancel()

        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}
