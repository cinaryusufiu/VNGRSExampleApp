//
//  MainTabbarVC.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import UIKit

final class MainTabbarVC: UITabBarController , UITabBarControllerDelegate {
  
    // MARK: - Properties
    
    weak var coordinator: Coordinator?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.black
        self.tabBar.backgroundColor = AppColor.yellowTan
        self.delegate = self
        
        let searchPokemon = UINavigationController(rootViewController: SearchPokemonVC())
        searchPokemon.tabBarItem = UITabBarItem(title: "Search",
                                                image: .actions,
                                                selectedImage: nil)
        
        let favPokemon = UINavigationController(rootViewController: FavoritePokemonVC())
        favPokemon.tabBarItem = UITabBarItem(title: "Fav",
                                             image: .checkmark,
                                                selectedImage: nil)
        
        self.viewControllers = [searchPokemon , favPokemon]
    }
}
