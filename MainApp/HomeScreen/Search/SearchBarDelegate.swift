//
//  SearchBar.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 29/08/2021.
//

import UIKit
extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        spinner.startAnimating()
        guard let text = searchBar.text, !text.isEmpty, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return }
        results.removeAll()
        searchItems(query: text)    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        spinner.startAnimating()
        searchBar.resignFirstResponder()
        guard let text = searchBar.text, !text.isEmpty, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return }
        results.removeAll()
        searchItems(query: text)
    }
    func searchItems(query: String){
        if hasFetched{
            filterItems(with: query)
        }
        else{
            DatabaseManager.shared.getItemsInCategory(categoryName: "", completion: { [weak self] result in
                switch result{
                case .success(let itemsCollection):
                    self?.hasFetched = true
                    self?.items = itemsCollection
                    self?.filterItems(with: query)
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    func filterItems(with term: String){
        var results: [GroceryItem] = items.filter({ element in
           let name = element.name.lowercased()
//            return name.hasPrefix(term.lowercased())
            return name.contains(term.lowercased())
        }).compactMap({ element in
            return GroceryItem(name: element.name, category: element.category, description: element.description, id: element.id, originalPrice: element.originalPrice, discount: element.discount, dateAdded: element.dateAdded, image: element.image, count: element.count, availableAmount: element.availableAmount)
        })
        results = results.sorted { ($0.name.lowercased().hasPrefix(term) ? 0 : 1) < ($1.name.lowercased().hasPrefix(term) ? 0 : 1) }
        self.results = results
        updateUI()
    }
    func updateUI() {
        spinner.stopAnimating()
        if results.isEmpty{
            resultsTable.isHidden = true
            noResultsLabel.isHidden = false
        }
        else {
            noResultsLabel.isHidden = true
            resultsTable.isHidden = false
            resultsTable.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.resultsTable.reloadData()
            }
        }
    }
}
