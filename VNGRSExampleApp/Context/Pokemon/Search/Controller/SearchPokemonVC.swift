//
//  SearchPokemonVC.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import UIKit
import NetworkPlatform
import Domain

final class SearchPokemonVC: VGBaseVC<SearchPokemonPage, SearchPokemonVM> {

    // MARK: - UI Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Properties
    
    var searchBarIsEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? false
    }
    
    var searchBarCount: Int {
        return searchController.searchBar.text?.count ?? 0
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        viewPage = SearchPokemonPage()
        viewModel = SearchPokemonVM(pokemons: [],
                                    usecase: NetworkPlatform.PokemonUseCaseProvider().makePokemonUseCase())
        super.loadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPage?.viewModel = viewModel
        prepareNavigation()
        bindUI()
        self.title = viewModel?.constant.screenName
        self.view.backgroundColor = AppColor.white
        prepareNavigation()
    }
    
    // MARK: - Override Functions
    
    override func updateUI() {
        super.updateUI()
        self.viewPage?.updateUI()
    }
    
    // MARK: - Private Functions
    
    private func bindUI() {
        viewPage?.didTappedCell = { [weak self] (index) in
            guard let self = self else { return }
            if let itemVM = viewModel?.pokemons[index] {
                RoutingEnum.pokemonDetail(itemVM).start()
            }
            self.searchController.isActive = false
        }
    }
    
    private func prepareNavigation(){
        self.navigationController?.view.backgroundColor = AppColor.white
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
}

extension SearchPokemonVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.remoaveAllItems()
        viewPage?.updateUI()
        viewModel?.textDidChange(searchText: searchText)
    }
}
