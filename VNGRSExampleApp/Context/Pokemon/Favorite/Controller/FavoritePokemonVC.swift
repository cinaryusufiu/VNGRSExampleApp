//
//  FavoritePokemonVC.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 17.08.2023.
//

import UIKit
import CachePlatform
import Domain

final class FavoritePokemonVC: VGBaseVC<FavoritePokemonPage, FavoritePokemonVM> {
    
    //MARK: - Properties
    
    override func loadView() {
        self.viewPage = FavoritePokemonPage()
        self.viewModel = FavoritePokemonVM(pokemons: [],
                                           usecase: CachePlatform.PokemonUseCaseProvider().makePokemonUseCase())
        super.loadView()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPage?.viewModel = viewModel
        self.title = viewModel?.constant.screenName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        self.viewModel?.fetchPokemons()
    }
    
    //MARK: - Override Functions
    
    override func updateUI() {
        super.updateUI()
        self.viewPage?.updateUI()
    }
    
    deinit {
        print("FavoritePokemonVC")
    }
}
