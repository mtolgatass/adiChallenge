//
//  ReviewServices.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 26.03.2021.
//

import Foundation

class ReviewServices {
    //MARK: - Variables
    static let shared = ReviewServices()
    
    //MARK: - ServiceCalls
    func submitReview(productId: String, reviewModel: [String: Any], completion: @escaping((ReviewModel?, APIError?) -> Void)) {
        BaseService.shared.submitReviewService(reviewModel: reviewModel, productId: productId) {
            switch $0 {
                case let .failure(error):
                    completion(nil, error)
                case let .success(review):
                    completion(review, nil)
            }
        }
    }
}
