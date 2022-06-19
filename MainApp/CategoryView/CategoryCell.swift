//
//  CategoryCell.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 31/08/2021.
//

import UIKit

//MARK: Cell for CATEGORY VIEW & CART
class CategoryCell: UITableViewCell {
    var groceryDiscount: String?
    var dateAdded: String?
    var categoryName: String?
    var productId: String?
    var productDescription: String?
    var availableAmount: Int?
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var discountPercentLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperCount: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepper.minimumValue = 1.0
        cartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        stepper.addTarget(self, action: #selector(stepperTapped(_:)), for: .touchUpInside)
       
        showAddToCart()
        stepperCount.text = String(Int(stepper.value))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //nth
    }
 
    func configureTableCell(with model: GroceryItem) {
        itemImageView.image = model.image.image
        nameLabel.text = model.name
        oldPriceLabel.text = "$" + model.originalPrice
        groceryDiscount = model.discount
        dateAdded = model.dateAdded
        categoryName = model.category
        productId = model.id
        availableAmount = model.availableAmount
        stepperCount.text = String(model.count)
        stepper.value = Double(model.count)
        productDescription = model.description
        priceLabel.text = "$" + String(((1 - Double(model.discount)!) * Double(model.originalPrice)!).rounded(toPlaces: 2))
        if groceryDiscount == "0" {
            noDiscount()
        }
        if Double(model.discount) == 0.0 {
            discountPercentLabel.isHidden = true
        }
        else {
            discountPercentLabel.text = String(Int(Double(model.discount)!*100)) + "% off!"
            discountPercentLabel.isHidden = false
        }
        self.addShadow()
        if let passedCount = stepperCount.text, passedCount != "0" {
            showStepper()
        }
        else {
            stepperCount.text = "1"
            showAddToCart()
        }
    }
}
