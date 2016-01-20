//
//  newsAppTests.swift
//  newsAppTests
//
//  Created by Miguel Gutiérrez Moreno on 22/1/15.
//  Copyright (c) 2015 MGM. All rights reserved.
//

import UIKit
import XCTest
@testable import newsApp

class newsAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testCoreData(){
        NSLog("testCoreData")
        
        XCTAssertNotNil(StoreNewsApp.defaultStore())
        
        XCTAssertTrue(Articulo.articulosAnterioresA(NSDate())?.count>0, "Debe ser mayor 0")

        
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
