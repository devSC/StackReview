//
//  PancakeHouseCollectionIntegrationTests.swift
//  StackReviewIntergationTests
//
//  Created by Wilson Yuan on 2018/3/13.
//  Copyright © 2018年 Razeware. All rights reserved.
//

import XCTest
@testable import StackReview

// async tests
class PancakeHouseCollectionIntegrationTests: XCTestCase {
    
    var collections: PancakeHouseCollection!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        collections = PancakeHouseCollection()
    }
    
    func testLoadPancakesFromCloudFails() {
        //given
        let expections = self.expectation(description: "Expeted load pancakes from cloud to fail")
        //when
        collections.loadPancakesFromCloud { (didReceiveData) in
            expections.fulfill()
            XCTAssertFalse(didReceiveData)
        }
        //then
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
