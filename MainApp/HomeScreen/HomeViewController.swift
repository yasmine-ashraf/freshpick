//
//  HomeViewController.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 29/08/2021.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var promoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var promoCheck: UIImageView!
    @IBOutlet weak var promoAddedLabel: UILabel!
    @IBOutlet weak var promoButton: UIButton!
    @IBOutlet weak var hiLabel: UILabel!
    @IBOutlet weak var categoriesView: UIView!
    @IBOutlet weak var homeSearchBar: UISearchBar!
    @IBOutlet weak var contentView: UIView!
    var loginObserver: NSObjectProtocol?
    var collectionViewObserver: NSObjectProtocol?
    var categories = [CategoryButton]()
    var populardeals:[GroceryItem] = [GroceryItem]()
    var spinner:UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.color = .systemGreen
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(spinner)
        spinner.startAnimating()
        homeSearchBar.delegate = self
        homeSearchBar.enablesReturnKeyAutomatically = true
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        popularCollectionView.register(UINib(nibName: "GroceryCollectionCell", bundle: .main), forCellWithReuseIdentifier: "groceryCollectionCell")
        promoButton.layer.borderColor = UIColor(red: 0.23, green: 0.55, blue: 0.15, alpha: 1.0).cgColor
        validateAuth()
        appendToCategories()
        addCategoriesToView()
        showIfPromoAdded()
        promoButton.addTarget(self, action: #selector(didTapPromo), for: .touchUpInside)
        loginObserver = NotificationCenter.default.addObserver(forName: .reloadHomeNotfication, object: nil, queue: .main, using: { [weak self] _ in
            DispatchQueue.main.async {
                self?.view.reloadInputViews()
            }
        })
        collectionViewObserver = NotificationCenter.default.addObserver(forName: .reloadPopularDeals, object: nil, queue: .main, using: { [weak self] _ in
            DispatchQueue.main.async {
                self?.popularCollectionView.reloadData()
            }
        })
        loadPopularDeals()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.hiLabel.text = "Hi ! \n\(UserDefaults.standard.string(forKey: "name") ?? "")"
            self.popularCollectionView.reloadData()
            self.spinner.stopAnimating()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
        popularCollectionView.reloadData()
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCategoriesFrames()
        spinner.center = popularCollectionView.center
    }
    deinit {
        if let observer = loginObserver{
            NotificationCenter.default.removeObserver(observer)
        }
        if let observer2 = collectionViewObserver{
            NotificationCenter.default.removeObserver(observer2)
        }
    }
}
//
//func manuallyAddingImage() {
//    guard let image = UIImage(named: "onions"), let data = image.pngData() else { return }
//    let fileName = "vegetables/onions.png"
//    StorageManager.shared.uploadImage(with: data, path: fileName, completion: { result in
//        switch result {
//        case .success(_):
//            print("uploaded \(fileName)")
//        case .failure(let error):
//            print("Error uploading image: \(error)")
//        }
//    })
//}
//        let dateString = DatabaseManager.dateFormatter.string(from: Date())
//        DatabaseManager.shared.insertItem(path: "deals", name: "Milk", category: "drinks", originalprice: "1.99", dateadded: dateString, discount: "0")
//        DatabaseManager.shared.insertItem(path: "items", name: "TunaFish", category: "fish", originalprice: "39.99", dateadded: dateString, discount: "0.2")
