//
//  StackReviewUITests.swift
//  StackReviewUITests
//
//  Created by Wilson Yuan on 2018/3/13.
//  Copyright © 2018年 Razeware. All rights reserved.
//

import XCTest

class StackReviewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    var horizontalSizeClass: XCUIElement.SizeClass {
        return app.windows.element(boundBy: 0).horizontalSizeClass
    }
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testCanNavigateToAboutScreen() {
        tapPancakeHouseButtonIfNeed()
        
        let aboutButton = app.navigationBars.buttons["About"]
        aboutButton.tap()
        
        let aboutTitleText = app.navigationBars.staticTexts["About"].firstMatch
        XCTAssertTrue(aboutTitleText.exists, "Should be on the about button")
    }
    
    func testCanNavigateToPancakeHouseScreen() {
        tapPancakeHouseButtonIfNeed()
        
        let tableText  = app.tables.staticTexts["Stack 'em High"]
        let pancakeText = app.staticTexts["Stack 'em High"]
        let map = app.maps.element
        tableText.tap()
        
        XCTAssertTrue(pancakeText.exists)
        XCTAssertTrue(map.exists)
        
    }
    
    func tapPancakeHouseButtonIfNeed() {
        guard horizontalSizeClass != .regular else {
            return
        }
        let pancakeHouseButton = app.navigationBars.buttons["Pancake Houses"]
        pancakeHouseButton.tap()
    }
}
