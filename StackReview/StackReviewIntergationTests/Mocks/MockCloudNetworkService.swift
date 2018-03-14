//
//  MockCloudNetworkService.swift
//  StackReviewIntergationTests
//
//  Created by Wilson Yuan on 2018/3/13.
//  Copyright © 2018年 Razeware. All rights reserved.
//

import UIKit
@testable import StackReview

class MockCloudNetworkService: CloudNetworkService {
    
    lazy var pancakeHouses: [PancakeHouse] = {
        let bundle = Bundle(for: MockCloudNetworkService.self)
        let path = bundle.path(forResource: "test_pancake_houses", ofType: "plist")!
        
        let array = NSArray(contentsOfFile: path)
        return PancakeHouse.from(array as! [[String : Any]])
    }()
    
    func login(userName: String, password: String, success: () -> (), failure: (Error) -> ()) {
        success()
    }
    
    func loadPancakeHouses(success: @escaping ([PancakeHouse]) -> (), failure: @escaping (CloudNetworkError) -> ()) {
        success(pancakeHouses)
    }
}
