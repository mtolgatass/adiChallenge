//
//  BaseService.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 24.03.2021.
//

import UIKit

enum APIError: Error {
    case internalError
    case serverError
    case parsingError
    case networkConnectionError
}

class BaseService: ServiceProvider {
    
    //MARK: - Variables
    static let shared = BaseService()
    private let baseUrl = "http://127.0.0.1"
    private var retryCounter: Int = 0
    
    private enum Endpoint: String {
        case products = "/product"
        case review = "/reviews"
    }
    private enum Method: String {
        case GET
        case POST
        
        init(fromRawValue: String) {
            self = Method(rawValue: fromRawValue) ?? .GET
        }
    }
    
    //MARK: - Base Service Calls
    private func request<T: Codable>(endpoint: String, method: Method, body: [String: Any]?, completion: @escaping((Result<T, APIError>) -> Void)) {
        
        let path = "\(baseUrl)\(endpoint)"
        
        guard let url = URL(string: path) else {
            completion(.failure(.internalError))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        if let body = body {
            let httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = httpBody
        }
        
        call(with: request, body: body, completion: completion)
    }
    
    private func call<T: Codable>(with request: URLRequest, body: [String: Any]?, completion: @escaping((Result<T, APIError>) -> Void)) {
        
        let dataTask = URLSession.shared.dataTask(with: request){ (data, response, error) in
            guard error == nil else {
                if !Reachability.sharedInstance.isNetworkConnectionAvailable() {
                    guard self.retryCounter < 5 else {
                        return
                    }
                    let tryAgainAction = UIAlertAction(title: "Try Again", style: .destructive) { (action) in
                        
                        self.request(endpoint: Endpoint.products.rawValue, method: Method(fromRawValue: request.httpMethod ?? "GET"), body: body, completion: completion)
                        self.retryCounter += 1
                    }
                    showAlertOnTopMostViewController(message: "No Network Connection", actions: [tryAgainAction])
                }
                completion(.failure(.serverError))
                return
            }
            
            self.retryCounter = 0
            
            do {
                guard let data = data else {
                    completion(.failure(.serverError))
                    return
                }
                
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(object))
            } catch {
                completion(Result.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
}

//MARK: - Service Calls
extension BaseService {
    func productsService(completion: @escaping ((Result<[ProductModel], APIError>) -> Void)) {
        request(endpoint: ":3001" + Endpoint.products.rawValue, method: .GET, body: nil, completion: completion)
    }
    
    func productDetailService(productId: String, completion: @escaping ((Result<ProductDetailModel, APIError>) -> Void)) {
        request(endpoint: ":3001" + Endpoint.products.rawValue + "/\(productId)", method: .GET, body: nil, completion: completion)
    }
    
    func submitReviewService(reviewModel: [String: Any], productId: String, completion: @escaping ((Result<ReviewModel, APIError>) -> Void)) {
        request(endpoint: ":3002" + Endpoint.review.rawValue + "/\(productId)", method: .POST, body: reviewModel, completion: completion)
    }
}

