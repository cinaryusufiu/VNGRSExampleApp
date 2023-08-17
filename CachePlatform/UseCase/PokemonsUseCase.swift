//
//  PokemonsUseCase.swift
//  CachePlatform
//
//  Created by Yusuf Çınar on 17.08.2023.
//

import Foundation
import Domain
import Combine

final class PokemonsUseCase: Domain.PokemonUseCase {
   
    private let cache: PokemonCache
    
    init(cache: PokemonCache) {
        self.cache = cache
    }
    
    func fetchAllPokemons(searchText: String?) -> AnyPublisher<Domain.ResponseModel<[Domain.Pokemon]>, Error> {
        return cache.fetchPokemons()
    }

    func checkFav(item: Domain.Pokemon) -> AnyPublisher<Domain.ResponseModel<Domain.Pokemon>, Error> {
        return cache.checkFavPokemon(pokemon: item)
    }
}
