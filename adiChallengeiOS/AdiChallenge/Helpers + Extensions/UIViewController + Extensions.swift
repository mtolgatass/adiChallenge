//
//  UIViewController + Extensions.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 26.03.2021.
//

import UIKit

extension UIViewController {
    func showError(error: APIError) {
        var errorMessage: String = ""
        
        switch error {
            case .internalError:
                errorMessage = "Internal error occured"
            case .serverError:
                errorMessage = "There is a problem with a server"
            default:
                errorMessage = "An error occured"
        }
        
        
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")


        }}))
        self.present(alert, animated: true, completion: nil)
    }
}
