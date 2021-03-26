//
//  ProductListInteractor.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 25.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProductListBusinessLogic {
    func fetchProductList()
}

class ProductListInteractor: ProductListBusinessLogic {
    var presenter: ProductListPresentationLogic?
    var worker: ProductListWorker = ProductListWorker()
  
    // MARK: - Fetch Products
  
    func fetchProductList() {
        worker.productListService(completion: { (model, error) in
            let response = ProductList.Response(productModel: model, error: error)
            self.presenter?.presentFetchedProducts(response: response)
        })
    }
}
