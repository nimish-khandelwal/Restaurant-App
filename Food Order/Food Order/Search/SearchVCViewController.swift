//
//  SearchVCViewController.swift
//  Food Order
//
//  Created by Ramesh Pendyala on 26/03/25.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var foodOutlets: [FoodOutlet] = []
    var filteredFoodOutlets: [FoodOutlet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        self.searchBar.delegate = self
        searchTableView.register(UINib(nibName: "FoodOutletTVCell", bundle: nil), forCellReuseIdentifier: "FoodOutletTVCell")
        self.foodOutlets = generateRandomFoodOutlets(count: 10)
        self.filteredFoodOutlets = []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.foodOutlets = generateRandomFoodOutlets(count: 10)
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchString = searchBar.text {
            if searchString.isEmpty {
                self.filteredFoodOutlets = []
            }else {
                self.filteredFoodOutlets = self.foodOutlets.filter( { $0.name.lowercased().contains(searchString.lowercased()) })
            }
        }
        self.searchTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.filteredFoodOutlets = []
        self.searchTableView.reloadData()
        self.searchBar.resignFirstResponder()
        self.view.endEditing(true)
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredFoodOutlets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodOutletTVCell", for: indexPath) as? FoodOutletTVCell else {
            return UITableViewCell()
        }
        let outlet = filteredFoodOutlets[indexPath.row]
        cell.configureCell(foodOutlet: outlet)
        return cell
    }
}









