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
        
        let navigationBar = app.navigationBars["About"].firstMatch
        let aboutTitleText = navigationBar.otherElements["About"]
        XCTAssertTrue(navigationBar.exists, "Should be on the about button")
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
    
    func testPancakeHouseScreenHasScrollView() {
        tapPancakeHouseButtonIfNeed()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Maison des Crêpes"]/*[[".cells.staticTexts[\"Maison des Crêpes\"]",".staticTexts[\"Maison des Crêpes\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.staticTexts["Ye Olde Pancake"]/*[[".cells.staticTexts[\"Ye Olde Pancake\"]",".staticTexts[\"Ye Olde Pancake\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        
        XCTAssertEqual(app.scrollViews.count, 1)
    }
    
    func testHideOrShowCopyrightNoticeOnAboutPage() {
        tapPancakeHouseButtonIfNeed()
        
        let aboutButton = app.navigationBars.buttons["About"]
        aboutButton.tap()
        
        let showHideButton = app.buttons["Show/Hide Copyright Notice"]
        showHideButton.tap()
        
        let axisSwitchButton = app.buttons["Axis Switch"]
        XCTAssertTrue(axisSwitchButton.exists)
        axisSwitchButton.tap()
        
        showHideButton.tap()
        XCTAssertFalse(axisSwitchButton.exists)
        
    }
    
    
    func tapPancakeHouseButtonIfNeed() {
        guard horizontalSizeClass != .regular else {
            return
        }
        let pancakeHouseButton = app.navigationBars.buttons["Pancake Houses"]
        pancakeHouseButton.tap()
    }
}
