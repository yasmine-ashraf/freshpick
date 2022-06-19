//
//  AddToCart.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 31/08/2021.
//

import Foundation
extension DatabaseManager {
    func addToCart(item: GroceryItem) {
        guard let safeEmail = UserDefaults.standard.string(forKey: "email")?.safeEmail() else {
            print("User email not stored")
            return
        }
        let path = "\(safeEmail)/cart"
        database.child(path).observeSingleEvent(of: .value, with: { snapshot in
            let newEntry: [String:String] = ["name": item.name,
                                             "category": item.category,
                                             "id": item.id,
                                             "description": item.description,
                                             "available_amount": String(item.availableAmount),
                                             "original_price": item.originalPrice,
                                             "discount": item.discount,
                                             "date_added": item.dateAdded,
                                             "count": String(item.count)]
            if var collection = snapshot.value as? [[String: String]] {
                //yeb2a 3ando cart
                let filterById = collection.filter({
                   return $0["id"] == item.id })
                if filterById.isEmpty{
                    collection.append(newEntry)
                    self.database.child(path).setValue(collection, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            return }
                        print("Added \(item.name) to cart")
                    })
                }
                else {
                    for index in 0..<collection.count {
                        if collection[index]["id"] == item.id {
                            collection[index] = newEntry
                            self.database.child(path).setValue(collection, withCompletionBlock: { error, _ in
                                guard error == nil else {
                                    return }
                                print("Updated \(item.name) count to \(item.count)")
                            })
                            
                        }
                    }
                }
            }
            else {
                //m3ndosh cart
                let newCollection: [[String:String]] = [newEntry]
                self.database.child(path).setValue(newCollection, withCompletionBlock: { error, _ in
                    guard error == nil else {
                        return }
                    print("Added \(item.name) to cart")
                })
            }

        })
    }
}
