//
//  ProductListWorkerTests.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 25.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import AdiChallenge
import XCTest

class ProductListWorkerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: ProductListWorker!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupProductListWorker()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupProductListWorker()
  {
    sut = ProductListWorker()
  }
  
  // MARK: Test doubles
  
  // MARK: Tests
  
  func testFetchProducts() {
    let expectation = self.expectation(description: "Wait for fetchProducts() to return.")
    sut.productListService { (product, error) in
        XCTAssert(error == nil, "Api Call Failed")
        expectation.fulfill()
    }
    waitForExpectations(timeout: 60)
  }
}