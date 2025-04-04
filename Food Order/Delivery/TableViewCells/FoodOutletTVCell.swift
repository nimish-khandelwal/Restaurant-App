//
//  FoodOutletTVCell.swift
//  Food Order
//
//  Created by Ramesh Pendyala on 25/03/25.
//

import UIKit

protocol FoodOutletTVCellDelegate: AnyObject {
    func didUpdateFavouriteStatus(for foodOutlet: FoodOutlet, index: IndexPath?)
}

class FoodOutletTVCell: UITableViewCell {
    
    @IBOutlet weak var mainView: UIView?
    @IBOutlet weak var outletImageView: UIImageView?
    @IBOutlet weak var nameLbl: UILabel?
    @IBOutlet weak var ratingLbl: UILabel?
    @IBOutlet weak var addressLbl: UILabel?
    @IBOutlet weak var favBtn: UIButton?
    
    weak var delegate: FoodOutletTVCellDelegate?
    var index: IndexPath? = nil
    
    @IBAction func didTapFavButton(_ sender: Any) {
        guard var foodOutlet = self.foodOutlet else { return }
        
        foodOutlet.isFavourite.toggle()
        self.foodOutlet = foodOutlet
        self.manageFavBtn()
        
        // Notify delegate to update the data source
        delegate?.didUpdateFavouriteStatus(for: foodOutlet, index: self.index)
    }
    
    var foodOutlet: FoodOutlet? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func didTapFavBtn() {
        if var foodOutlet = self.foodOutlet {
            foodOutlet.isFavourite = !foodOutlet.isFavourite
            self.foodOutlet = foodOutlet
            self.manageFavBtn()
        }
        //Todo: Delegate to pass new food outlet item
    }
    
    @objc func didSelectOutlet() {
        //Todo: Navigate to restaurant screen
    }
    
    func setupUI() {
        self.favBtn?.tintColor = .systemPink
        self.mainView?.layer.borderColor = UIColor.lightGray.cgColor
        //Todo: add gesture recognise to mainView and Action = didSelectOutlet
    }
    
    func configureCell(foodOutlet: FoodOutlet) {
        self.foodOutlet = foodOutlet
        self.nameLbl?.text = foodOutlet.name
        self.addressLbl?.text = "Address: " + foodOutlet.address
        self.ratingLbl?.text = "\(foodOutlet.rating).0"
        //self.outletImageView?.image = foodOutlet.image
        self.manageFavBtn()
    }
    
    func manageFavBtn() {
        guard let foodOutlet = self.foodOutlet else { return }
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        
        if foodOutlet.isFavourite {
            let heartImage = UIImage(systemName: "heart.circle.fill", withConfiguration: symbolConfig)
            self.favBtn?.setImage(heartImage, for: .normal)
            self.favBtn?.tintColor = .systemPink
            self.favBtn?.backgroundColor = .white
            self.favBtn?.layer.cornerRadius = self.favBtn?.frame.height ?? 0 / 2
            self.favBtn?.isHidden = false
        }else {
            self.favBtn?.isHidden = true
        }
        return
    }
    
}


