//
//  Calculations.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 01/09/2021.
//

import Foundation
extension CartViewController {
    func calculate() {
        let cartPrices = cartItems.map({ Double($0.originalPrice)! * (1.0 - Double($0.discount)!) })
        let subtotal = cartPrices.reduce(0, { runningSum, value in
            runningSum + value
        })
        let afterTax = subtotal * 0.03
        var total = afterTax + subtotal
        var afterPromo = 0.0
        if UserDefaults.standard.bool(forKey: "promo") {
            afterPromo = subtotal * 0.35
            total = total - afterPromo
            discountAmount.text = "- $" + String(afterPromo.rounded(toPlaces: 2))
        }
        subtotalAmount.text = "$" + String(subtotal.rounded(toPlaces: 2))
        taxAmount.text = "+ $" + String(afterTax.rounded(toPlaces: 2))
        totalAmount.text = "$" + String(total.rounded(toPlaces: 2))
    }

}
