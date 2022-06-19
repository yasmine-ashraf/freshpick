//
//  ItemViewController.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 06/09/2021.
//

import UIKit

class ItemViewController: UIViewController {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperCount: UILabel!
    @IBOutlet weak var infoStack: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var oldPriceLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var inStockLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    var groceryItem: GroceryItem?
    override func viewDidLoad() {
        guard let model = groceryItem else {
            return
        }
        view.backgroundColor = UIColor(red: 0.76, green: 0.91, blue: 0.77, alpha: 1.00)
        stepper.transform = stepper.transform.scaledBy(x: 1.9, y: 1.6)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .systemGreen
        configure(with: model)
        checkInStock(model: model)
        checkCountInCart()
        addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        stepper.addTarget(self, action: #selector(stepperTapped(_:)), for: .touchUpInside)
    }
}

