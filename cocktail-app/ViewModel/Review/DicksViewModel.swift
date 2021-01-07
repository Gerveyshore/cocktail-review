//
//  DrinksViewModel.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-02.
//

import Foundation
import UIKit

class DicksViewModel {

    private var cocktailService: CocktailService?
    private var drinksData : [Drink]?
    var cellIdentifier = "DrinksTableViewCell"
        
    init() {
        cocktailService = CocktailService()
    }
    
    var numberOfDrinks: Int {
        return drinksData?.count ?? 0
    }
    
    func drink(at row: Int) -> Drink? {
        return drinksData?[row]
    }
    
    func getImage(at row: Int, _ completion: ((UIImage?) -> Void)?) {
        if let drinkThumbnailLink = drinksData?[row].thumbnailLink {
            cocktailService?.fetchImageData(from: drinkThumbnailLink, completionHandler: { data in
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    completion?(image)
                }
            })
        } else {
            completion?(nil)
        }
    }
    
    func getOrdinaryDrinks(_ completion: (() -> Void)?) {
        cocktailService?.fetchDrinksByCategory(category: "Ordinary_Drink", completion: { (drinks) in
            self.drinksData = drinks.all
            completion?()
        })
    }
}
