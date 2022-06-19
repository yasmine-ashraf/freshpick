//
//  CartViewController.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 31/08/2021.
//

import UIKit

class CartViewController: UIViewController {
    var promoObserver: NSObjectProtocol?
    var cartObserver: NSObjectProtocol?
    var cartItems = [GroceryItem]()
    var spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.color = .systemGreen
        return spinner
    }()
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var recieptStack: UIStackView!
    @IBOutlet weak var valuesStack: UIStackView!
    @IBOutlet weak var cartEmptyLabel: UILabel!
    @IBOutlet weak var checkoutOutlet: UIButton!
    @IBOutlet weak var discountTitle: UILabel!
    @IBOutlet weak var subtotalAmount: UILabel!
    @IBOutlet weak var taxAmount: UILabel!
    @IBOutlet weak var discountAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBAction func checkoutButton(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "OrderPlacedViewController") as? OrderPlacedViewController else {
            return
        }
        tabBarController?.selectedIndex = 0
        DatabaseManager.shared.clearCartFromDatabase()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        spinner.startAnimating()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Cart"
        if !UserDefaults.standard.bool(forKey: "promo") {
            discountTitle.isHidden = true
            discountAmount.isHidden = true
        }
        cartTableView.register(UINib(nibName: "CategoryCell", bundle: .main), forCellReuseIdentifier:  "CategoryCell")
        DatabaseManager.shared.getItemsInCategory(categoryName: "cart", completion: { [weak self] result in
            switch result {
            case .success(let items):
                self?.cartItems = items
                self?.cartTableView.reloadData()
                self?.hideIfEmpty()
            case .failure(_):
                self?.hideIfEmpty()
                print("Cart found empty")
            }
        })
        cartObserver = NotificationCenter.default.addObserver(forName: .reloadCart, object: nil, queue: .main, using: { [weak self] _ in
            DispatchQueue.main.async {
                self?.cartTableView.reloadData()
                self?.calculate()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.cartTableView.reloadData()
            self.view.reloadInputViews()
            self.spinner.stopAnimating()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cartTableView.reloadData()
        calculate()
        if UserDefaults.standard.bool(forKey: "promo") {
            discountTitle.isHidden = false
            discountAmount.isHidden = false
        }
       hideIfEmpty()
        DatabaseManager.shared.getItemsInCategory(categoryName: "cart", completion: { [weak self] result in
            switch result {
            case .success(let items):
                self?.cartItems = items
                self?.cartTableView.reloadData()
                self?.hideIfEmpty()
            case .failure(_):
                self?.cartItems = [GroceryItem]()
                self?.hideIfEmpty()
                print("Cart found empty")
            }
        })
    }
    override func viewDidLayoutSubviews() {
        spinner.center = view.center
    }
    deinit {
        if let observer = cartObserver {
            NotificationCenter.default.removeObserver(observer)
        }
        
    }
    
    func hideIfEmpty() {
        if cartItems.isEmpty {
            cartEmptyLabel.isHidden = false
            cartTableView.isHidden = true
            recieptStack.isHidden = true
            valuesStack.isHidden = true
            checkoutOutlet.isHidden = true
        }
        else {
            cartEmptyLabel.isHidden = true
            cartTableView.isHidden = false
            recieptStack.isHidden = false
            valuesStack.isHidden = false
            checkoutOutlet.isHidden = false
        }
    }
}
