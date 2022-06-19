//
//  GroceryCollectionCell.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 30/08/2021.
//

import UIKit

class GroceryCollectionCell: UICollectionViewCell {
    var groceryDiscount: String?
    var dateAdded: String?
    var categoryName: String?
    var productId: String?
    var productDescription: String?
    var availableAmount: Int?
    var collectionCellDelegate: CollectionCellDelegate?
    @IBOutlet weak var groceryImage: UIImageView!
    @IBOutlet weak var groceryName: UILabel!
    @IBOutlet weak var groceryPrice: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var selectedCount: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedCount.minimumValue = 1.0
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        selectedCount.addTarget(self, action: #selector(stepperTapped(_:)), for: .touchUpInside)
        countLabel.adjustsFontSizeToFitWidth = true
    }
    func unhideAddToCart() {
        selectedCount.isHidden = true
        countLabel.isHidden = true
        addToCartButton.isHidden = false
    }
    func unhideStepper() {
        addToCartButton.isHidden = true
        selectedCount.isHidden = false
        countLabel.isHidden = false
    }
   
    func configureCollectionCell(with model: GroceryItem) {
        groceryImage.image = model.image.image
        groceryName.text = model.name
        oldPrice.text = "$" + model.originalPrice
        groceryPrice.text =  "$" + String(((1 - Double(model.discount)!) * Double(model.originalPrice)!).rounded(toPlaces: 2))
        groceryDiscount = model.discount
        categoryName = model.category
        productId = model.id
        dateAdded = model.dateAdded
        productDescription = model.description
        availableAmount = model.availableAmount
        countLabel.text = String(model.count)
        selectedCount.value = Double(model.count)
        addShadow()
        if let passedCount = countLabel.text, passedCount != "0" {
            unhideStepper()
        }
        else {
            countLabel.text = "1"
            unhideAddToCart()
        }
        if groceryDiscount == "0" {
            oldPrice.isHidden = true
        }
    }
}
