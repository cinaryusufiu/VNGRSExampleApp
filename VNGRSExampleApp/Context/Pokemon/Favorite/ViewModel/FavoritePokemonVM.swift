//
//  FavoritePokemonVM.swift
//  VNGRSExampleApp
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation
import Domain
import Combine

final class FavoritePokemonVM: VGBaseVM {
    
    // MARK: - Properties
    
    private(set) var pokemons: [PokemonDetailVM] = []
    private let usecase: Domain.PokemonUseCase
    private var subscriptions = Set<AnyCancellable>()
    
    override var constant: VGBaseVMConstant {
        return VGBaseVMConstant(screenName: "FavoritePokemon")
    }
    
    init(pokemons: [PokemonDetailVM], usecase: Domain.PokemonUseCase) {
        self.pokemons = pokemons
        self.usecase = usecase
    }
    
    // MARK: - Public Functions
    
    func fetchPokemons() {
        self.state?(.loading(false))
        usecase.fetchAllPokemons(searchText: nil).receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure:
                    self.state?(.failure(StateErrorType.unknown.getValue()))
                case .finished:
                    break
                }
            }) { responseModel in
                guard responseModel.cards?.count ?? 0 > 0 else {
                    self.state?(.failure(StateErrorType.parserNotWork.getValue()))
                    return
                }
                self.pokemons.removeAll()
                self.pokemons.append(contentsOf: responseModel.cards?.map({PokemonDetailVM(model: $0)}) ?? [])
                self.state?(.success)
            }.store(in: &subscriptions)
    }
    
    func itemVM(index: Int) -> PokemonDetailVM? {
        if pokemons.indices.contains(index)  {
            return pokemons[index]
        }
        return nil
    }
    
    func numberOfItems() -> Int {
        return pokemons.count
    }
}
