//
//  DrinksTableViewDataSource.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-04.
//

import Foundation
import UIKit

class DicksTableViewDataSource: NSObject, UITableViewDataSource {

    private weak var viewModel: DicksViewModel?
    
    required init(withViewModel viewModel: DicksViewModel) {
        self.viewModel = viewModel
    }
    
    var cellIdentifier: String {
        return viewModel?.cellIdentifier ?? ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfDrinks ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DrinksTableViewCell else {
            return tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        }
        if let drink = viewModel?.drink(at: indexPath.row) {
            cell.setupView(with: drink)
        }
        
        viewModel?.getImage(at: indexPath.row) { image in
            cell.setupImageView(with: image)
        }
        
        return cell
    }
}
