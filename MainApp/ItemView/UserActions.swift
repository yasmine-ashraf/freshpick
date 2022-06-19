//
//  Actions.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 09/09/2021.
//

import UIKit
extension ItemViewController {
    @objc func addToCartTapped() {
        showStepper()
        stepperCount.text = String(Int(stepper.value))
        guard var newGroceryItem = groceryItem else {
            return
        }
        newGroceryItem.count = 1
        newGroceryItem.availableAmount -= 1
        self.groceryItem?.availableAmount -= 1
        DatabaseManager.shared.addToCart(item: newGroceryItem)
        DatabaseManager.shared.updateCountInDatabase(incrementValue: -1, targetId: newGroceryItem.id)
    }
    @objc func stepperTapped(_ sender: UIStepper) {
        guard var groceryItem = self.groceryItem else {
            return
        }
        var incrementValue = 0
        if let text = stepperCount.text, let prevCountUser = Double(text), prevCountUser < stepper.value {
            //user increased this item in his cart so decrease available amount
            incrementValue = -1
        }
        else {
            incrementValue = 1
        }
        groceryItem.availableAmount += incrementValue
        self.groceryItem?.availableAmount += incrementValue
        DatabaseManager.shared.updateCountInDatabase(incrementValue: incrementValue, targetId: groceryItem.id)
        if stepper.value == 1.00 &&  stepperCount.text == "1" {
            //user had 1 in cart and decreased stepper again so they want it to be 0
            showAddToCart()
            DatabaseManager.shared.removeFromCart(itemId: groceryItem.id)
        }
        else {
            let currentCount = Int(stepper.value)
            groceryItem.count = currentCount
            self.groceryItem?.count = currentCount
            DatabaseManager.shared.addToCart(item: groceryItem)
            stepperCount.text = String(currentCount)
        }
        checkInStock(model: groceryItem)
    }
}
