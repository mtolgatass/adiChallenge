//
//  ServiceProvider.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 25.03.2021.
//

import Foundation

protocol ServiceProvider {
    
    //MARK: -Service Functions
    func productsService(completion: @escaping((Result<[ProductModel], APIError>) -> Void))
    func productDetailService(productId: String, completion: @escaping((Result<ProductDetailModel, APIError>) -> Void))
}
