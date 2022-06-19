//
//  getItemsInCategory.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 30/08/2021.
//
import Foundation
import SDWebImage
extension DatabaseManager {
    public func getItemsInCategory(categoryName: String, completion: @escaping (Result<[GroceryItem],Error>) -> Void) {
        var categoryLowercase = categoryName.lowercased().replacingOccurrences(of: " ", with: "")
        var path = "items"
        if categoryName == "deals" {
            path = "deals"
        }
        else if categoryName == "cart" {
            guard let email = UserDefaults.standard.string(forKey: "email") else {
                return
            }
            let safeEmail = email.safeEmail()
            path = "\(safeEmail)/cart"
        }
        database.child(path).observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [[String:Any]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            var items: [GroceryItem] = value.compactMap({ dictionary in
                guard let itemName = dictionary["name"] as? String,
                      let category = dictionary["category"] as? String,
                      let description = dictionary["description"] as? String,
                      let id = dictionary["id"] as? String,
                      let originalPrice = dictionary["original_price"] as? String,
                      let discount = dictionary["discount"] as? String,
                      let availableAmount = dictionary["available_amount"] as? String,
                      let dateAdded = dictionary["date_added"] as? String else {
                    return nil
                }
                var itemCount = 0
                if categoryName == "cart" {
                    categoryLowercase = category
                    if let itemCountString: String = dictionary["count"] as? String {
                        itemCount = Int(itemCountString)!
                    }
                }
                else if categoryName.isEmpty {
                    categoryLowercase = category
                }
                let tempImageView = UIImageView(image: UIImage(named: "placeholder"))
                let groceryItem = GroceryItem(name: itemName, category: category, description: description, id: id, originalPrice: originalPrice, discount: discount, dateAdded: dateAdded, image: tempImageView, count: itemCount, availableAmount: Int(availableAmount) ?? 0)
                let imagePath = itemName.lowercased().replacingOccurrences(of: " ", with: "")
                if category == categoryLowercase || categoryLowercase == "deals" || categoryName == "cart" {
                    StorageManager.shared.downloadURL(for: "\(categoryLowercase)/\(imagePath).png", completion: { result in
                        switch result {
                        case .success(let url):
                            groceryItem.image.sd_setImage(with: url, completed: nil)
                            NotificationCenter.default.post(Notification(name: .reloadCategory))
                            NotificationCenter.default.post(Notification(name: .reloadCart))
                            NotificationCenter.default.post(Notification(name: .reloadPopularDeals))
                        case .failure(let error):
                            print("Failed to set img \(error)")
                        }
                    })
                }
                return groceryItem
            })
            if path == "items" && !categoryName.isEmpty {
                items = items.filter({
                    return $0.category == categoryLowercase })
            }
            else if categoryName == "cart" {
                items = items.filter({
                    return $0.count > 0
                })
            }
            if path == "cart" {
                completion(.success(items))
            }
            else {
                self.loadCountFromCart(array: items, completion: { result in
                    switch result {
                    case .success(let countItems):
                        var updatedItems = items
                        for obj in countItems {
                            for i in 0..<updatedItems.count {
                                if obj.id == updatedItems[i].id {
                                    updatedItems[i].count = obj.count
                                }
                            }
                        }
                        completion(.success(updatedItems))
                    case .failure(let error):
                        completion(.failure(error))
                    }
            })
            }
            NotificationCenter.default.post(Notification(name: .reloadPopularDeals))
        })
    }
}

//
//self.loadCountFromCart(array: items, completion: { result in
//    switch result {
//    case .success(let updatedItems):
//        NotificationCenter.default.post(Notification(name: .reloadPopularDeals))
//        completion(.success(updatedItems))
//        
//    
//    case .failure(let error):
//        print("Failed to get items \(error)")
//    
//}
//})
//})
//}
//}
