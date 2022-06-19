//
//  HomeSearchBar.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 02/09/2021.
//

import UIKit
extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard let vc = storyboard?.instantiateViewController(identifier: "SearchViewController") else {
            return }
        navigationController?.pushViewController(vc, animated: true)
        homeSearchBar.resignFirstResponder()
    }
}
