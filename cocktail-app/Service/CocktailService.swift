//
//  CocktailService.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-02.
//

import Foundation
import Alamofire

class CocktailService {

    let endpoint = "https://www.thecocktaildb.com/api/json/v1/1";
    static let sharedInstance = CocktailService()

    func fetchDrinksByCategory(category: String = "Ordinary_Drink", completion:@escaping (Drinks)->()) {
        let request = AF.request("\(self.endpoint)/filter.php?c=\(category)")

        request.responseDecodable(of: Drinks.self) { (response) in
            guard let drinks = response.value else {
                print("Error decoding")
                print(response)
                return
            }
            completion(drinks)
        }
    }
    
    func fetchDetailedDrinkById(id: String, completion:@escaping (DetailedDrink)->()) {
        let request = AF.request("\(self.endpoint)/lookup.php?i=\(id)")
        print("\(self.endpoint)/lookup.php?i=\(id)")
        request.responseDecodable(of: DetailedDrinks.self) { (response) in
            guard let detailedDrinksResponse = response.value else {
                print("Error decoding detailedDrinksResponse")
                print(response)
                return
            }
            guard let detailedDrink = detailedDrinksResponse.all.first else {
                print("Error decoding detailedDrink")
                print(response)
                return
            }
            completion(detailedDrink)
        }
    }
    
    //                self.fetchImage(from: link){ (imageData) in
    //                        if let data = imageData {
    //                            // referenced imageView from main thread
    //                            // as iOS SDK warns not to use images from
    //                            // a background thread
    //                            DispatchQueue.main.async {
    //                                cell.imageThumbnail.image = UIImage(data: data)
    //                            }
    //                        } else {
    //                            print("Error loading image");
    //                        }
    //                    }
    
    func fetchImageData(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        let url = URL(string: urlString)
            
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("Error fetching the image! 😢")
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
        dataTask.resume()
    }
}
