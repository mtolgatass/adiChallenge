//
//  ProductDetailModel.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 25.03.2021.
//

import Foundation

struct ProductDetailModel: Codable {
    
    //MARK: - Variables
    var currency: String?
    var price: Int?
    var id: String?
    var name: String?
    var description: String?
    var imgUrl: String?
    var reviews: [ReviewModel]?
}
