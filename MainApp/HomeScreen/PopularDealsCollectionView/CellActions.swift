//
//  CellActions.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 01/09/2021.
//

import UIKit
extension GroceryCollectionCell {
    
    @objc func addToCartTapped() {
        guard let name = groceryName.text, let price = groceryPrice.text?.replacingOccurrences(of: "$", with: ""), let groceryDiscount = self.groceryDiscount, let dateAdded = self.dateAdded, let fromCategory = self.categoryName, let id = self.productId, let description = self.productDescription, let prevAvailableAmount = self.availableAmount else {
            print("not all data was passed to popular deals collection view")
            return
        }
        collectionCellDelegate?.updateItem(id: id, toCount: 1)
        unhideStepper()
        countLabel.text = String(Int(selectedCount.value))
        self.availableAmount? -= 1
        let newGroceryItem = GroceryItem(name: name, category: fromCategory, description: description, id: id, originalPrice: price, discount: groceryDiscount, dateAdded: dateAdded, image: groceryImage, count: 1, availableAmount: prevAvailableAmount-1)
        DatabaseManager.shared.updateCountInDatabase(incrementValue: -1, targetId: id)
        DatabaseManager.shared.addToCart(item: newGroceryItem)
    }
    
    @objc func stepperTapped(_ sender: UIStepper) {
        guard let name = groceryName.text, let price = groceryPrice.text?.replacingOccurrences(of: "$", with: ""), let groceryDiscount = self.groceryDiscount, let dateAdded = self.dateAdded, let fromCategory = self.categoryName, let id = self.productId, let description = self.productDescription, let prevAvailableAmount = self.availableAmount else {
            print("not all data was passed to popular deals collection view")
            return
        }
        if selectedCount.value == 1.00 &&  countLabel.text == "1" {
            unhideAddToCart()
            DatabaseManager.shared.removeFromCart(itemId: id)
        }
        else {
            var incrementValue = 0
            if let text = countLabel.text, let prevCountUser = Double(text), prevCountUser < selectedCount.value {
                //yeb2a user zawed ml item di 3ndo so decrease available amount
                incrementValue = -1
            }
            else {
                incrementValue = 1
            }
            let newAvailableAmount = prevAvailableAmount + incrementValue
            self.availableAmount? += incrementValue
            DatabaseManager.shared.updateCountInDatabase(incrementValue: incrementValue, targetId: id)
            let currentCount = Int(sender.value)
            collectionCellDelegate?.updateItem(id: id, toCount: currentCount)
            let incrementedItem = GroceryItem(name: name, category: fromCategory, description: description, id: id, originalPrice: price, discount: groceryDiscount, dateAdded: dateAdded, image: groceryImage, count: currentCount, availableAmount: newAvailableAmount)
            DatabaseManager.shared.addToCart(item: incrementedItem)
            countLabel.text = String(Int(selectedCount.value))
        }
    }
}
protocol CollectionCellDelegate {
    func updateItem(id: String, toCount: Int)
}
