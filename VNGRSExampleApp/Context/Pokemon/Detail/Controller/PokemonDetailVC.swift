//
//  PokemonDetailVC.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import UIKit
import Domain

final class PokemonDetailVC: VGBaseVC<PokemonDetailPage, PokemonDetailVM> {
    
    //MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func loadView() {
        viewPage = PokemonDetailPage()
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPage?.viewModel = viewModel
        bindUI()
        self.viewModel?.fetchPokemons()
    }
    
    //MARK: - Override Functions
    
    override func configureInit() {
        super.configureInit()
        guard let routingEnum = routingEnum, case let RoutingEnum.pokemonDetail(viewModel: viewModel) = routingEnum else { return }
        self.viewModel = viewModel
    }
    
    override func updateUI() {
        super.updateUI()
        self.viewPage?.updateUI()
    }
    
    override func completeUI() {
        super.completeUI()
        self.viewPage?.updateUI()
    }
    // MARK: - Private Functions
    
    private func bindUI() {
        viewPage?.didTapLikeButton = { [weak self] in
            guard let self = self else { return }
            self.viewModel?.savePokemon()
        }
    }
}
