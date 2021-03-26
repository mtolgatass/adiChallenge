//
//  ProductListPresenterTests.swift
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

class ProductListPresenterTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: ProductListPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupProductListPresenter()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupProductListPresenter()
    {
        sut = ProductListPresenter()
    }
    
    // MARK: Test doubles
    
    class ProductListDisplayLogicSpy: ProductListDisplayLogic {
        
        // MARK: Method call expectations
        var displayProductsCalled = false
        var displayErrorCalled = false
        
        // MARK: Spied methods
        func displayError(error: APIError) {
            displayErrorCalled = true
        }
        
        func displayProductList(viewModel: ProductList.ViewModel) {
            displayProductsCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentProducts()
    {
        // Given
        let productListDisplayLogicSpy = ProductListDisplayLogicSpy()
        sut.viewController = productListDisplayLogicSpy
        let expectation = self.expectation(description: "Wait for fetchProducts to return.")
        var products: [ProductModel]?
        let worker = ProductListWorker()
        worker.productListService { (product, error) in
            expectation.fulfill()
            products = product
        }
        waitForExpectations(timeout: 60)
        let successfulResponse = ProductList.Response(productModel: products, error: nil)
        let failedResponse = ProductList.Response(productModel: nil, error: APIError.internalError)
        
        // When
        sut.presentFetchedProducts(response: successfulResponse)
        sut.presentFetchedProducts(response: failedResponse)
        
        // Then
        XCTAssertTrue(productListDisplayLogicSpy.displayProductsCalled, "presentFetchedProducts(response:) should ask the view controller to display the result")
        XCTAssertTrue(productListDisplayLogicSpy.displayErrorCalled, "If message is not nil presentError will be called.")
    }
}