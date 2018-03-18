//
//  BullsEyeTests.swift
//  BullsEyeTests
//
//  Created by Wilson-Yuan on 2018/3/17.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import XCTest
@testable import BullsEye

class BullsEyeTests: XCTestCase {
    
    var gameUnderTest: BullsEyeGame!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameUnderTest = BullsEyeGame()
        gameUnderTest.startNewGame()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        gameUnderTest = nil
        super.tearDown()
    }
    
    func testScoreIsComputed() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //1. given
        let guss = gameUnderTest.targetValue - 5
        
        //2. when
        _ = gameUnderTest.check(guess: guss)
        
        //3. then
        XCTAssertEqual(gameUnderTest.scoreRound, 95)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
