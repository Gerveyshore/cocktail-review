//
//  ViewController.swift
//  cocktail-app
//
//  Created by Philippe Le on 2020-12-31.
//

import UIKit
import Alamofire

class ViewController: UIViewController, DrinkCellDelegate {

    @IBOutlet weak var drinksTableView: UITableView!

    //HERE #1: ViewModel est créé dès que ViewController est initialisé.
    private var drinksViewModel = DicksViewModel()
    //HERE #2: DataSource n'est pas créé puisqu'elle a besoin du viewModel. Elle est optional pour éviter des crashs (?)
    private var dataSource : DicksTableViewDataSource?
    private var drinkId : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeDataSource()
        fetchDrinks()
    }
    
    func initializeDataSource() {
        //HERE #3: J'ai enlevé ton update. J'ai aussi refait ta datasource et ton viewmodel pour que ca fasse un peu plus de sens.
        //Tes cellules sont pu lié à un élément.
        dataSource = DicksTableViewDataSource(withViewModel: drinksViewModel)
        drinksTableView.dataSource = dataSource
        //HERE #10: Voici d'ou ton delegate va commencer
        drinksTableView.delegate = self
    }
    
    func fetchDrinks() {
        //HERE #4: Je fetch les drinks quand le viewController est prêt. On aurait pu le faire de 100 façons (ex: en background ailleurs pendant que l'app load, avec un loading, etc.. mais pas besoin pour une simple démo app comme ca.
        drinksViewModel.getOrdinaryDrinks {
            DispatchQueue.main.async {
                self.drinksTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let vc = segue.destination as! DetailedViewController && (segue.identifier == "SegueToDetailedView"){
//            vc.delegate = self
//        }
//        
//        if (segue.identifier == "SegueToDetailedView") {
//            let vc = segue.destination as! DetailedViewController
//            vc.drinkId = self.drinkId
//        }
    }
    
    func drinkCellPressed(drinkId: String) {
        print("in ViewController")
        print(drinkId)
        self.drinkId = drinkId
    }
}

extension ViewController: UITableViewDelegate {
    
    //HERE #11: Après avoir mis ton delegate à self à #10, si tu cliques sur une cellule, cette méthode est appelé.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Je suggère aussi de séparé ton DetailedViewController de ton storyboard.
        //Je vais faire un mini exemple pour te montrer comment simple c'est.

        let dickDetailedViewController = UIViewController() //bien sur ici ce sera ton DetailedViewController
        dickDetailedViewController.view.backgroundColor = .yellow
        DispatchQueue.main.async {
            self.present(dickDetailedViewController, animated: true, completion: nil)
        }
        
        //Voila, pas besoin de segue et toute cette merde.
        //Pour créé ton ViewController, assez simple:
        //New File
        //Swift File
        //UIViewController + click on .xib
    }
}

