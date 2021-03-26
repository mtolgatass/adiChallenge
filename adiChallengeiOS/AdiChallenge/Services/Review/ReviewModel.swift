//
//  ReviewModel.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 25.03.2021.
//

import Foundation

struct ReviewModel: Codable {
    
    //MARK: - Variables
    var productId: String?
    var locale: String?
    var rating: Int?
    var text: String?
}
