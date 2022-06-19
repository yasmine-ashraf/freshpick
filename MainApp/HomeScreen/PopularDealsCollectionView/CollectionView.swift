//
//  CollectionView.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 30/08/2021.
//

import UIKit
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        populardeals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GroceryCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "groceryCollectionCell", for: indexPath) as! GroceryCollectionCell
        cell.collectionCellDelegate = self
        cell.configureCollectionCell(with: populardeals[indexPath.row])
        return cell
    }
    ///Loads items in popular deals from DatabaseManager
    func loadPopularDeals() {
        DatabaseManager.shared.getItemsInCategory(categoryName: "deals", completion: { [weak self] result in
            switch result {
            case .success(let deals):
                self?.populardeals = deals
                self?.loginObserver = NotificationCenter.default.addObserver(forName: .reloadHomeNotfication, object: nil, queue: .main, using: { [weak self] _ in
                self?.popularCollectionView.reloadData()
                })
            case .failure(let error):
                print("Error retrieving deals \(error)")
            }})
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "ItemViewController") as? ItemViewController else {
            return
        }
        vc.groceryItem = populardeals[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
