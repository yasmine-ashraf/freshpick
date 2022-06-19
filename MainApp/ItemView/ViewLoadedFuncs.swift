//
//  ViewLoadedFuncs.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 09/09/2021.
//

import Foundation
extension ItemViewController {
    
    func configure(with model: GroceryItem) {
        itemImageView.image = model.image.image
        nameLabel.text = model.name
        descriptionLabel.text = model.description
        oldPriceLabel.text = "$" + model.originalPrice
        currentPriceLabel.text = "$" + String(((1 - Double(model.discount)!) * Double(model.originalPrice)!).rounded(toPlaces: 2))
        idLabel.text = "Product Code: " + model.id
        dateLabel.text = "Date Added: " + model.dateAdded
        stepperCount.text = String(model.count)
        stepper.value = Double(model.count)
        if model.discount == "0" {
            oldPriceLabel.isHidden = true
        }
        if model.category == "fruits" || model.category == "vegetables" {
            weightLabel.text = "Weight: 1 kg"
        }
        else {
            weightLabel.isHidden = true
        }
    }
    
    func showAddToCart() {
        addToCartButton.isHidden = false
        stepper.isHidden = true
        stepperCount.isHidden = true
    }
    func showStepper() {
        addToCartButton.isHidden = true
        stepper.isHidden = false
        stepperCount.isHidden = false
    }
    
    func checkInStock(model: GroceryItem) {
        if model.availableAmount > 10 {
            inStockLabel.isHidden = true
        }
        else {
            inStockLabel.isHidden = false
            inStockLabel.text = "Hurry! Only \(model.availableAmount) left in stock"
        }
    }
    func checkCountInCart() {
        if let passedCount = stepperCount.text, passedCount != "0" {
            showStepper()
        }
        else {
            stepperCount.text = "1"
            showAddToCart()
        }
    }
    
}
