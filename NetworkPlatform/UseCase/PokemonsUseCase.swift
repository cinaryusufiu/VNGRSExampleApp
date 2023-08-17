//
//  PokemonsUseCase.swift
//  NetworkPlatform
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation
import Domain
import Combine

final class PokemonsUseCase: Domain.PokemonUseCase {
   
    private let network: PokemonNetwork
    
    init(network: PokemonNetwork) {
        self.network = network
    }
    
    func fetchAllPokemons(searchText: String?) -> AnyPublisher<Domain.ResponseModel<[Domain.Pokemon]>, Error> {
        return network.fetchPokemons(searchText: searchText)
    }

    func checkFav(item: Domain.Pokemon) -> AnyPublisher<Domain.ResponseModel<Domain.Pokemon>, Error> {
        return network.savePokemon()
    }
}
