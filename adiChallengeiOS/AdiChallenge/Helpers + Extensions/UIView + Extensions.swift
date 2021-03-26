//
//  UIView + Extensions.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 26.03.2021.
//

import UIKit

extension UIView {
    static let loadingViewTag = 1938123987
    
    func showLoading(style: UIActivityIndicatorView.Style = .medium) {
        var loading = self.viewWithTag(UIImageView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }
        
        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading?.startAnimating()
        loading?.hidesWhenStopped = true
        loading?.tag = UIView.loadingViewTag
        self.addSubview(loading!)
        loading?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func stopLoading() {
        let loading = self.viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}
