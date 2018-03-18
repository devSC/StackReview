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
        let houses = givenNewPancakeHouses()
        
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
    
    func testMeasureLoadDefaultPancakeHouses() {
        measure {
            self.collection.loadDefaultPancakeHouses()
        }
    }
    
    func testElementIsFavoritePancake() {
        //given
        let element = collection[0]
        let otherElement = collection[1]
        XCTAssertFalse(collection.isFavorite(element))
        //when
        collection.favorite = element
        //then
        XCTAssertTrue(collection.isFavorite(element))
        XCTAssertFalse(collection.isFavorite(otherElement))
    }
    
    func testOutElementIsNotFavoritePancake() {
        let houses = givenNewPancakeHouses()
        //given
        XCTAssertFalse(collection.isFavorite(houses))
        //when
        collection.favorite = houses
        //then
        XCTAssertNil(collection.favorite)
        XCTAssertFalse(collection.isFavorite(houses), "favorite pancake is the element of collections")
    }
    
    func testRemoveFavoritePancakeHouses() {
        //given
        let house = collection[0]
        //when
        collection.favorite = house
        //then
        XCTAssertTrue(collection.isFavorite(house))
        XCTAssertThrowsError(try collection.removePancakeHouse(house), "Should not be allowned to remove favorite pancake house") {
            let error = $0 as! PancakseHouseError
            XCTAssertEqual(error, PancakseHouseError.triedToRemoveFavoritePancakeHouse)
        }
    }
    
    func testRemoveUnknowPancakeHouses() {
        //given
        let house = givenNewPancakeHouses()
        
        //then
        XCTAssertThrowsError(try collection.removePancakeHouse(house), "Should not be allowned to remove unknow pancake house") {
            let error = $0 as! PancakseHouseError
            XCTAssertEqual(error, PancakseHouseError.triedToRemoveUnknownPancakeHouse)
        }
    }
    
    func givenNewPancakeHouses() -> PancakeHouse {
        let dict: [String: Any] = ["name": "Test Pancake House",
                                   "priceGuide": 1,
                                   "rating": 1,
                                   "details": "Test"]
        return PancakeHouse(dictionary: dict)!
    }
    
    func verifyPancakeHousesHaseExpetedValues(index: Int) {
        let pancakeHouse = collection[index]
        let plistIndex = index + 1
        
        XCTAssertEqual(pancakeHouse.name, "name \(plistIndex)")
        XCTAssertEqual(pancakeHouse.details, "details \(plistIndex)")
        XCTAssertEqual(pancakeHouse.photo, UIImage(named: "pancake\(plistIndex)"))
    }

    
}
