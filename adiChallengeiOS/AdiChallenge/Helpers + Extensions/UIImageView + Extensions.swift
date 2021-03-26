//
//  UIImageView + Extensions.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 25.03.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromUrl(url: String, completion: @escaping(UIImage) -> Void) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.main.async {
            do {
                let data = try Data(contentsOf: url)
                completion(UIImage(data: data) ?? UIImage())
            } catch {
                completion(UIImage(named: "placeholder") ?? UIImage())
                print(error.localizedDescription)
            }
        }
    }
}
