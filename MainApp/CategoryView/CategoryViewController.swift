//
//  CategoryTableViewController.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 31/08/2021.
//

import UIKit

class CategoryViewController: UIViewController {
    var itemsInCategory = [GroceryItem]()
    var categoryName: String?
//    var previousStepperValue = 0.0
    @IBOutlet weak var tableView: UITableView!
    var spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.color = .systemGreen
        return spinner
    }()
    var categoryObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .systemGreen
        view.addSubview(spinner)
        spinner.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CategoryCell", bundle: .main), forCellReuseIdentifier:  "CategoryCell")
        guard let categoryName = self.categoryName else { return }
        navigationItem.title = categoryName.capitalized
        DatabaseManager.shared.getItemsInCategory(categoryName: categoryName, completion: { [weak self] result in
            switch result {
            case .success(let items):
                self?.itemsInCategory = items
                self?.tableView.reloadData()
            case .failure(let error):
                print("Error retrieving category items \(error)")
            }})
        categoryObserver = NotificationCenter.default.addObserver(forName: .reloadCategory, object: nil, queue: .main, using: { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        spinner.center = view.center
    }
    deinit {
        if let observer = categoryObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
