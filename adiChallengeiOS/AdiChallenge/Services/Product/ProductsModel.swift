//
//  ProductsModel.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 24.03.2021.
//

import Foundation

struct ProductModel: Codable {
    
    //MARK: - Variables
    var currency: String?
    var price: Double?
    var id: String?
    var name: String?
    var description: String?
    var imgUrl: String
    var reviews: [ReviewModel]?
}
