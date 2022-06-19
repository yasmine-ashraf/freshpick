//
//  ClearCart.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 31/08/2021.
//

import Foundation
extension DatabaseManager {
    func clearCartFromDatabase() {
        //in real life i'd save this cart to orders
        guard let safeEmail = UserDefaults.standard.string(forKey: "email")?.safeEmail() else {
            return
        }
        database.child("\(safeEmail)/cart").setValue(nil, withCompletionBlock: { error, _ in
            guard error == nil else {
                print("Couldn't delete cart")
                return
            }
            NotificationCenter.default.post(Notification(name: .reloadCart))
            NotificationCenter.default.post(Notification(name: .reloadPopularDeals))
            
        })
    }
    func removeFromCart(itemId: String) {
        guard let safeEmail = UserDefaults.standard.string(forKey: "email")?.safeEmail() else {
            return
        }
        database.child("\(safeEmail)/cart").observe(.value, with: { [weak self] snapshot in
            if var cartItems = snapshot.value as? [[String:Any]] {
                var positionToRemove = 0
                for item in cartItems{
                    if let id = item["id"] as? String, id == itemId {
                        cartItems.remove(at: positionToRemove)
                        break
                    }
                    positionToRemove += 1
                }
                self?.database.child("\(safeEmail)/cart").setValue(cartItems, withCompletionBlock: { error, _ in
                    guard error == nil else {
                        return }
                })
            }
        })
    }
}
