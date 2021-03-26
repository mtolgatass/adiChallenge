//
//  ProductListViewModel.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 25.03.2021.
//

import Foundation

final class ProductListViewModel {
    
    var resultModel: [ProductModel] = []
    
    init(resultModel : [ProductModel]) {
        self.resultModel = resultModel
    }
}
