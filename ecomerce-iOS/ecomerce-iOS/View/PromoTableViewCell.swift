//
//  PromoTableViewCell.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 13/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit
import Nuke

class PromoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var promoImage: UIImageView!
    @IBOutlet weak var loveIcon: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(product: ProductPromo) {
        title.text = product.title
        guard let imageURL = URL(string: product.imageUrl) else { return }
        loadImage(with: imageURL, into: promoImage)
        
        if product.loved == 1 {
            loveIcon.image = UIImage(named: "loveFill")
        }
    }
}
