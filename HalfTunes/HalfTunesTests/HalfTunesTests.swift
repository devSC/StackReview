//
//  HalfTunesTests.swift
//  HalfTunesTests
//
//  Created by Wilson-Yuan on 2018/3/17.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import HalfTunes

class HalfTunesTests: XCTestCase {
    
    var sessionUnderTest: URLSession!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sessionUnderTest = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sessionUnderTest = nil;
        super.tearDown()
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidCallToiTunesGetsHttpStatusCode200() {
        
        //given
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        
        let promise = expectation(description: "Status code 200")
        
        let dataTask = sessionUnderTest.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            }
            else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                }
                else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // Asynchronous test: faster fail
    func testCallToiTunesCompletes() {
        
        //given
        let url = URL(string: "https://itunes.apple.com/search?media=music&entity=song&term=abba")
        
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?

        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            
            promise.fulfill()
        }
        
        dataTask.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        //then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
