//
//  CartTableDelegate.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 01/09/2021.
//

import UIKit

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CategoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.configureTableCell(with: cartItems[indexPath.row])
        cell.cartButton.isHidden = true
        cell.stepper.isHidden = false
        cell.stepperCount.isHidden = false
        cell.stepper.value = Double(cartItems[indexPath.row].count)
        cell.addShadow()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = storyboard?.instantiateViewController(identifier: "ItemViewController") as? ItemViewController else {
            return
        }
        vc.groceryItem = cartItems[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
