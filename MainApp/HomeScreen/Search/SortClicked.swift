//
//  SortClicked.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 02/09/2021.
//

import UIKit
extension SearchViewController {
    func sortClicked() {
        spinner.startAnimating()
        let alert = UIAlertController(title: "Sort", message: "Select sorting priority", preferredStyle: .actionSheet)
        var newTitle = "Sort by: "
        alert.addAction(UIAlertAction(title: "Name: Ascending", style: .default, handler: { [weak self] (action) in
            newTitle += "Name"
            self?.results.sortAlphabetically()
        }))
        alert.addAction(UIAlertAction(title: "Date Added: Latest", style: .default, handler: { [weak self] (action) in
            newTitle += "Date"
            self?.results.sortLatestDate()
        }))
        alert.addAction(UIAlertAction(title: "Price: Low to High", style: .default, handler: { [weak self] (action) in
            newTitle += "Price (Low)"
            self?.results.sortAscendingPrice()
        }))
        alert.addAction(UIAlertAction(title: "Price: High to Low", style: .default, handler: { [weak self] (action) in
            newTitle += "Price (High)"
            self?.results.sortDescendingPrice()
        }))
        alert.addAction(UIAlertAction(title: "Discount: Highest Rate", style: .default, handler: { [weak self] (action) in
            newTitle += "Discount"
            self?.results.sortHighestDiscountRate()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.reloadInputViews()
            self.sortLabel.setTitle(newTitle, for: .normal)
            self.resultsTable.reloadData()
            self.spinner.stopAnimating()
        }
    }
}
