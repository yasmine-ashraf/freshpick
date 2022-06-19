//
//  HandlingCategories.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 29/08/2021.
//

import UIKit
extension HomeViewController {
    @objc private func didTapCategory(_ sender: CategoryButton) {
        guard let name = sender.viewModel?.title else {
            print("error getting the name of selected category")
            return
        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        vc.categoryName = name.lowercased().replacingOccurrences(of: " ", with: "")
        navigationController?.pushViewController(vc, animated: true)
        print("selected \(name) Category")
    }
    func appendToCategories() {
        categories.append(CategoryButton(with: CategoryButtonViewModel(imageName: "vegetables", title: "Vegetables", bgColor: UIColor(red: 0.76, green: 0.91, blue: 0.77, alpha: 1.00)))) //green
        categories.append(CategoryButton(with: CategoryButtonViewModel(imageName: "fruits", title: "Fruits", bgColor: UIColor(red: 0.83, green: 0.77, blue: 0.98, alpha: 1.00)))) //purple
        categories.append(CategoryButton(with: CategoryButtonViewModel(imageName: "fish", title: "Fish", bgColor: UIColor(red: 1.00, green: 0.95, blue: 0.74, alpha: 1.00)))) //yellow
        categories.append(CategoryButton(with: CategoryButtonViewModel(imageName: "meat", title: "Meat", bgColor: UIColor(red: 0.92, green: 0.59, blue: 0.58, alpha: 1.00)))) //pink
        categories.append(CategoryButton(with: CategoryButtonViewModel(imageName: "drinks", title: "Drinks", bgColor: UIColor(red: 0.77, green: 0.87, blue: 0.99, alpha: 1.00)))) //blue
    }
    func addCategoriesToView() {
        for category in categories {
            categoriesView.addSubview(category)
            category.addTarget(self, action: #selector(didTapCategory(_:)), for: .touchUpInside)
        }
    }
    func setCategoriesFrames() {
        categories[0].frame = CGRect(x: 0, y: 0, width: (categoriesView.width-20)/5, height: categoriesView.height-10)
        for i in 1..<categories.count {
            categories[i].frame = CGRect(x: categories[i-1].right+5, y: 0, width: (categoriesView.width-20)/5, height: categoriesView.height-10)
        }
    }
}
