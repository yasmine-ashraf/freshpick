//
//  CellProtocolDelegate.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 02/09/2021.
//

import Foundation
extension HomeViewController: CollectionCellDelegate {
    func updateItem(id: String, toCount: Int) {
        for i in 0..<populardeals.count {
            if populardeals[i].id == id {
                populardeals[i].count = toCount
                return
            }
        }
    }
}
