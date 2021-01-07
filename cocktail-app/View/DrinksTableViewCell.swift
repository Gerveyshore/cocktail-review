//
//  DrinksTableViewCell.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-04.
//

import Foundation
import UIKit

class DrinksTableViewCell: UITableViewCell {

    @IBOutlet weak var drinkIdLabel: UILabel?
    @IBOutlet weak var drinkNameLabel: UILabel?
    @IBOutlet weak var imageThumbnail: UIImageView?
    
    weak var delegate: DrinkCellDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        delegate?.drinkCellPressed(drinkId: self.drinkIdLabel.text!)
    }
    
    func setupThumbailImageView() {
        imageThumbnail?.contentMode = .scaleAspectFit
    }
    
    func setupView(with drink: Drink) {
        drinkIdLabel?.text = drink.id
        drinkNameLabel?.text = drink.name
        
        setupThumbailImageView()
    }
    
    func setupImageView(with image: UIImage?) {
        DispatchQueue.main.async {
            self.imageThumbnail?.image = image ?? UIImage()
        }
    }
}

protocol DrinkCellDelegate: class {
    func drinkCellPressed(drinkId: String)
}
