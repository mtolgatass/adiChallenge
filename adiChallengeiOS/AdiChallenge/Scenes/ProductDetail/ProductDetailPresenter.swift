//
//  ProductDetailPresenter.swift
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

protocol ProductDetailPresentationLogic {
    func presentFetchedProductDetail(response: ProductDetail.ProductDetail.Response)
    func handleSubmitReviewResult(response: ProductDetail.SubmitReview.Response)
}

class ProductDetailPresenter: ProductDetailPresentationLogic {
    weak var viewController: ProductDetailDisplayLogic?
  
    // MARK: Response Present Functions
  
    func presentFetchedProductDetail(response: ProductDetail.ProductDetail.Response) {
        guard let product = response.productDetailModel else {
            //TODO: HANDLE ERROR
            return
        }
        let productDetailViewModel = ProductDetailViewModel(resultModel: product)
        let viewModel = ProductDetail.ProductDetail.ViewModel(displayResult: productDetailViewModel)
        viewController?.displayProductDetail(viewModel: viewModel)
    }
    
    func handleSubmitReviewResult(response: ProductDetail.SubmitReview.Response) {
        guard let response = response.result else {
            //TODO: HANDLE ERROR
            return
        }
        
        viewController?.submitReviewResponseHandler(result: response)
    }
}