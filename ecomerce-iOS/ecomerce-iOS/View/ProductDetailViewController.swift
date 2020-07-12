//
//  ProductDetailViewController.swift
//  ecomerce-iOS
//
//  Created by Yonathan Wijaya on 13/07/20.
//  Copyright © 2020 Yonathan Wijaya. All rights reserved.
//

import UIKit
import Nuke
class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loveImag: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    var product: ProductPromo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(product: product!)
        // Do any additional setup after loading the view.
    }


    func setup(product: ProductPromo) {
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        priceLabel.text = product.price
        guard let imageURL = URL(string: product.imageUrl) else { return }
        loadImage(with: imageURL, into: img)
        
        if product.loved == 1 {
            loveImag.image = UIImage(named: "loveFill")
        }
    }

    @IBAction func buyAction(_ sender: Any) {
        
    }
}
