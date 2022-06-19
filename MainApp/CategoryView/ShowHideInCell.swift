//
//  ShowHideInCell.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 01/09/2021.
//

import Foundation
extension CategoryCell {
    func noDiscount() {
        oldPriceLabel.isHidden = true
        discountPercentLabel.isHidden = true
    }
    func showDiscount() {
        oldPriceLabel.isHidden = false
        discountPercentLabel.isHidden = false
    }
    func showAddToCart() {
        cartButton.isHidden = false
        stepper.isHidden = true
        stepperCount.isHidden = true
    }
    func showStepper() {
        cartButton.isHidden = true
        stepper.isHidden = false
        stepperCount.isHidden = false
    }
}

