//
//  DrinksTableViewDataSource.swift
//  cocktail-app
//
//  Created by Philippe Le on 2021-01-04.
//

import Foundation
import UIKit

class DicksTableViewDataSource: NSObject, UITableViewDataSource {
    
    //HERE #6: La datasource de la tableview est un peu plus simple ici que tu l'avais fait. Tout ce qu'elle fait s'est conformé à UITableViewDataSource et avoir ton viewModel pour aller chercher l'info que tu as besoin pour tes/ta cellule.
    //viewModel est optional ici. Elle est aussi weak pcq viewController détient la STRONG référence.. alors tu ne veux pas de memory leak
    //comme tu vois, exemple pour numberOfRowsInSection. Je me sers du ? pcq c'est optional et ensuite ?? pour donner une valeur par défaut au cas ou viewModel soit nil. J'aurais pu faire un if let blablabla ou guard let blablabla.. mais pour du simple code comme ca, toujours simple d'utiliser les ??.

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
            //HERE #7: Avant tu changais les values de ta cellule dans ton viewController. Maintenant je laisse la cellule le faire à ma place. Tout ce que je fais, c'est qu'à l'aide du viewModel, je vais chercher mon drink à la row que je désire et puis je passe le drink en paramêtre et la cellule fait ce qu'elle veut avec.
            cell.setupView(with: drink)
        }
        
        viewModel?.getImage(at: indexPath.row) { image in
            //HERE #8: Comme #7, par contre, ici c'est async (d'ou la completion) puisque je dois attendre une réponse de la requête. La cellule va alors faire sa job comme pour #7.
            cell.setupImageView(with: image)
        }
        
        return cell
    }
}
