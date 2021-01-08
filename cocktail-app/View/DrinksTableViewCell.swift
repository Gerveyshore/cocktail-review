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
    
    //HERE #9: J'ai enlevé ton delegate puisque tu n'en as pas besoin. Il y a déjà un truc par qui s'appelle UITableViewDelegate qui existe. Je vais te le montrer au HERE #10.
//    weak var delegate: DrinkCellDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
