//
//  CategoryCollectionViewCell.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 13/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit
import Nuke

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

     func setupCell(product: Category) {
        title.text = product.name
           guard let imageURL = URL(string: product.imageUrl) else { return }
           loadImage(with: imageURL, into: image)
       }
}
