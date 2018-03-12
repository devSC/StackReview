//
//  PancakHouseCollectionTests.swift
//  StackReviewTests
//
//  Created by Wilson-Yuan on 2018/3/12.
//  Copyright © 2018 Razeware. All rights reserved.
//

import XCTest
@testable import StackReview

class PancakHouseCollectionTests: XCTestCase {
    
    var collection: PancakeHouseCollection!
    
    
    override func setUp() {
        super.setUp()
        
        collection = PancakeHouseCollection()
        
        let bundle = Bundle(for: PancakHouseCollectionTests.self)
        collection.loadPancakeHouses("test_pancake_houses", in: bundle)
    }
    
    func testCollectionHasExpectedItemsCount() {
        XCTAssert(collection.count == 3, "Collection did't have expected number of items")
    }
    
    func testFirstPancakeHousesHaseExpetedValues() {
        verifyPancakeHousesHaseExpetedValues(index: 0)
    }
    
    func testSecondPancakeHousesHaseExpetedValues() {
        verifyPancakeHousesHaseExpetedValues(index: 1)
    }
    
    func testThirdPancakeHousesHaseExpetedValues() {
        verifyPancakeHousesHaseExpetedValues(index: 2)
    }
    
    func testAddable() {
        //given
        let dict: [String: Any] = ["name": "Test Pancake House",
                                   "priceGuide": 1,
                                   "rating": 1,
                                   "details": "Test"]
        
        guard let houses = PancakeHouse(dictionary: dict) else {
            XCTAssert(false, "Empty houses")
            return
        }
        
        //when
        collection.addPancakeHouse(houses)
        
        //then
        XCTAssert(collection._pancakeHouses.contains(houses), "Collections ditn't container the houses")
    }
    
    func testRemoveable() {
        //given
        let lastone = collection[collection.count - 1]
        
        //when
        do {
            try collection.removePancakeHouse(lastone)
        } catch {
            print("error: \(error)")
            XCTAssert(false, "Remove pancake house failed")
        }
        
        XCTAssertFalse(collection._pancakeHouses.contains(lastone), "remve failed")
    }
    
    func verifyPancakeHousesHaseExpetedValues(index: Int) {
        let pancakeHouse = collection[index]
        let plistIndex = index + 1
        
        XCTAssertEqual(pancakeHouse.name, "name \(plistIndex)")
        XCTAssertEqual(pancakeHouse.details, "details \(plistIndex)")
        XCTAssertEqual(pancakeHouse.photo, UIImage(named: "pancake\(plistIndex)"))
    }

    
}
