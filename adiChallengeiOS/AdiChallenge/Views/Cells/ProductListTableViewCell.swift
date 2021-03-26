//
//  ProductListTableViewCell.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 26.03.2021.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
