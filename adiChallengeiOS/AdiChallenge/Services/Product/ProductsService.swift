//
//  ProductsService.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 24.03.2021.
//

import Foundation

class ProductsService {
    //MARK: - Variables
    static let shared = ProductsService()
    
    //MARK: - ServiceCalls
    func productServiceCall(completion: @escaping(([ProductModel]?, APIError?) -> Void)) {
        BaseService.shared.productsService {
            switch $0 {
                case let .failure(error):
                    completion(nil, error)
                case let .success(products):
                    completion(products, nil)
            }
        }
    }
    
    func productDetailServiceCall(productId: String, completion: @escaping((ProductDetailModel?, APIError?) -> Void)) {
        BaseService.shared.productDetailService(productId: productId) {
            switch $0 {
                case let .failure(error):
                    completion(nil, error)
                case let .success(product):
                    completion(product, nil)
            }
        }
    }
}
