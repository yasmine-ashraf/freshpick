//
//  CategoryCellActions.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 01/09/2021.
//

import UIKit
extension CategoryCell {
    @objc func addToCartTapped() {
        guard let name = nameLabel.text, let price = oldPriceLabel.text?.replacingOccurrences(of: "$", with: ""), let groceryDiscount = self.groceryDiscount, let dateAdded = self.dateAdded, let fromCategory = self.categoryName, let id = self.productId, let description = self.productDescription, let prevAvailableAmount = self.availableAmount else {
            print("not all data was passed to popular deals collection view")
            return
        }
        showStepper()
        stepperCount.text = String(Int(stepper.value))
        DatabaseManager.shared.updateCountInDatabase(incrementValue: -1, targetId: id)
        let newGroceryItem = GroceryItem(name: name, category: fromCategory, description: description, id: id, originalPrice: price, discount: groceryDiscount, dateAdded: dateAdded, image: itemImageView, count: 1, availableAmount: prevAvailableAmount - 1)
        DatabaseManager.shared.addToCart(item: newGroceryItem)
        self.availableAmount? -= 1
    }
    @objc func stepperTapped(_ sender: UIStepper) {
        guard let name = nameLabel.text, let price = oldPriceLabel.text?.replacingOccurrences(of: "$", with: ""), let groceryDiscount = self.groceryDiscount, let dateAdded = self.dateAdded, let fromCategory = self.categoryName, let id = self.productId, let description = self.productDescription, let prevAvailableAmount = self.availableAmount else {
            print("not all data was passed to popular deals collection view")
            return
        }
        var newAvailableAmount = 100
        if let text = stepperCount.text, let prevCountUser = Double(text), prevCountUser < stepper.value {
            //yeb2a user zawed ml item di 3ndo
            //so decrease available amount
            newAvailableAmount = prevAvailableAmount - 1
            self.availableAmount? -= 1
            DatabaseManager.shared.updateCountInDatabase(incrementValue: -1, targetId: id)

        }
        else {
            newAvailableAmount = prevAvailableAmount + 1
            self.availableAmount? += 1
            DatabaseManager.shared.updateCountInDatabase(incrementValue: +1, targetId: id)
        }
        if stepper.value == 1.00 &&  stepperCount.text == "1" {
            showAddToCart()
            DatabaseManager.shared.removeFromCart(itemId: id)
            //remove ml cart
        }
        else {
            let currentCount = Int(stepper.value)
            let incrementedItem = GroceryItem(name: name, category: fromCategory, description: description, id: id, originalPrice: price, discount: groceryDiscount, dateAdded: dateAdded, image: itemImageView, count: currentCount, availableAmount: newAvailableAmount)
            DatabaseManager.shared.addToCart(item: incrementedItem)
            stepperCount.text = String(currentCount)
        }
    }
}
