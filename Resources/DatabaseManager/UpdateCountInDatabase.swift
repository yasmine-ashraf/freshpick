//
//  UpdateCountInDatabase.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 02/09/2021.
//

import Foundation
extension DatabaseManager {
    func updateCountInDatabase(incrementValue: Int, targetId: String) {
        database.child("items/").observeSingleEvent(of: .value, with: { snapshot in
            guard var value = snapshot.value as? [[String:String]] else {
                //Cart empty
                return
            }
            for i in 0..<value.count {
                if value[i]["id"] == targetId {
                    guard let amountString = value[i]["available_amount"], let amount = Int(amountString) else {
                        return
                    }
                    value[i]["available_amount"] = String(amount+incrementValue)
                    self.database.child("items/").setValue(value, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            return }
                        print("Updated \(targetId) available amount in database")
                    })
                    break
                }
            }
        })
        //do the same for deals
        database.child("deals/").observeSingleEvent(of: .value, with: { snapshot in
            guard var value = snapshot.value as? [[String:String]] else {
                //Cart empty
                return
            }
            for i in 0..<value.count {
                if value[i]["id"] == targetId {
                    guard let amountString = value[i]["available_amount"], let amount = Int(amountString) else {
                        return
                    }
                    value[i]["available_amount"] = String(amount+incrementValue)
                    self.database.child("deals/").setValue(value, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            return }
                        print("Updated \(targetId) available amount in database")
                    })
                    break
                }
            }
        })
    }
    //            let newArray: [GroceryItem] = value.compactMap({ dictionary in
    //                guard let itemName = dictionary["name"] as? String,
    //                      let category = dictionary["category"] as? String,
    //                      let description = dictionary["description"] as? String,
    //                      let id = dictionary["id"] as? String,
    //                      let originalPrice = dictionary["original_price"] as? String,
    //                      let discount = dictionary["discount"] as? String,
    //                      let availableAmount = dictionary["available_amount"] as? String,
    //                      var availableAmountInt = Int(availableAmount),
    //                      let dateAdded = dictionary["date_added"] as? String else {
    //                    return nil
    //                }
    //                if id == targetId {
    //                    availableAmountInt += incrementValue
    //                }
    //                let updatedItem = GroceryItem(name: itemName, category: category, description: description, id: id, originalPrice: originalPrice, discount: discount, dateAdded: dateAdded, image: UIImageView(), count: Int(count)!, availableAmount: 0)
    //                return updatedItem
    //            })
    //        }
//    )}
}
