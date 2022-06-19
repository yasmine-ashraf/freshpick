//
//  Promo.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 31/08/2021.
//

import Foundation
extension HomeViewController {
    func showIfPromoAdded() {
        if UserDefaults.standard.bool(forKey: "promo") {
            showPromoAdded()
        }
        else {
            showAddPromo()
        }
    }
    @objc func didTapPromo() {
        showPromoAdded()
        UserDefaults.standard.setValue(true, forKey: "promo")
    }
    func showPromoAdded() {
        promoButton.isHidden = true
        promoCheck.isHidden = false
        promoAddedLabel.isHidden = false
    }
    func showAddPromo() {
        promoButton.isHidden = false
        promoCheck.isHidden = true
        promoAddedLabel.isHidden = true
    }
    
}
