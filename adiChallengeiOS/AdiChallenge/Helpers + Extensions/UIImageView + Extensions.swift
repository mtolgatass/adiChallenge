//
//  UIImageView + Extensions.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 25.03.2021.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromUrl(url: String) {
        guard let url = URL(string: url) else { return }
        DispatchQueue.main.async {
            do {
                let data = try Data(contentsOf: url)
                self.image = UIImage(data: data)
            } catch {
                self.image = UIImage(named: "placeholder")
                print(error.localizedDescription)
            }
        }
    }
}
