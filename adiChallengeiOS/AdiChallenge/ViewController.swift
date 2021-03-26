//
//  ViewController.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 24.03.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchProductsList()
        fetchProductDetail(id: "HI333")
    }
    
    func fetchProductsList() {
        ProductsService.shared.productServiceCall { products, error  in
            return
        }
    }
    
    func fetchProductDetail(id: String) {
        ProductsService.shared.productDetailServiceCall(productId: id) { productDetail, error in
            return
        }
    }


}

