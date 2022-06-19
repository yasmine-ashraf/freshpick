//
//  SearchViewController.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 02/09/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    var items = [GroceryItem]()
    var results = [GroceryItem]()
    public var completion: ((GroceryItem) -> (Void))?
    var hasFetched = false
    var spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.color = .systemGreen
        return spinner
    }()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTable: UITableView!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBAction func sortButton(_ sender: UIButton) {
        sortClicked()
        resultsTable.reloadData()
    }
    @IBOutlet weak var sortLabel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsTable.delegate = self
        resultsTable.dataSource = self
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.becomeFirstResponder()
        view.addSubview(spinner)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .systemGreen
        sortLabel.titleLabel?.adjustsFontSizeToFitWidth = true
        resultsTable.register(UINib(nibName: "CategoryCell", bundle: .main), forCellReuseIdentifier:  "CategoryCell")
        noResultsLabel.isHidden = true
    }
    override func viewDidLayoutSubviews() {
        spinner.center = view.center
    }
}
