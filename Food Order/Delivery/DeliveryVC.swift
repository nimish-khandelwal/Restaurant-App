//
//  Untitled.swift
//  Food Order
//
//  Created by Ramesh Pendyala on 25/03/25.
//

import UIKit

struct FoodOutlet {
    var name: String = ""
    var rating: Int = 0
    var address: String = ""
    var lat: CGFloat = 0.0
    var long: CGFloat = 0.0
    var isFavourite: Bool = false
    var image: UIImage? = nil
    
    init(name: String, rating: Int, address: String, lat: CGFloat, long: CGFloat, isFavourite: Bool, image: UIImage? = nil) {
        self.name = name
        self.rating = rating
        self.address = address
        self.lat = lat
        self.long = long
        self.isFavourite = isFavourite
        self.image = image
    }
}

class DeliveryVC: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var logoView: UIView!
    
    @IBOutlet weak var mytableView: UITableView!
    
    var foodOutlets: [FoodOutlet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.foodOutlets = generateRandomFoodOutlets(count: 10)
        self.setupTableViewController()
    }
    
    func setupTableViewController() {
        self.mytableView.delegate = self
        self.mytableView.dataSource = self
        self.mytableView.register(UINib(nibName: "FoodOutletTVCell", bundle: nil), forCellReuseIdentifier: "FoodOutletTVCell")
        self.mytableView.reloadData()
    }
}
extension DeliveryVC: FoodOutletTVCellDelegate {
    func didUpdateFavouriteStatus(for updatedOutlet: FoodOutlet, index: IndexPath?) {
        if let index = index?.row {
            if index >= 0 && index < self.foodOutlets.count {
                self.foodOutlets[index] = updatedOutlet
                publicOutlets = foodOutlets
            }
        }
    }
}
extension DeliveryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foodOutlets.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodOutletTVCell", for: indexPath) as? FoodOutletTVCell else {
            return UITableViewCell()
        }
        let outlet = self.foodOutlets[indexPath.row]
        cell.index = indexPath
        cell.configureCell(foodOutlet: outlet)
        cell.delegate = self
        return cell
//        cell.configureCell(foodOutlet: self.foodOutlets[indexPath.row])
//        return cell
    }
}

