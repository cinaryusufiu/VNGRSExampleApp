//
//  PokemonCache.swift
//  CachePlatform
//
//  Created by Yusuf Çınar on 17.08.2023.
//

import Foundation
import Domain
import Combine
import SwiftyUserDefaults

public final class PokemonCache {

    private let cache: UserCache
    
    let currentValueFetch = CurrentValueSubject<ResponseModel<[Pokemon]>, Error>(ResponseModel<[Pokemon]>.init(cards: Defaults[\.pokemons] ?? []))
    
    let currentValueFav = CurrentValueSubject<ResponseModel<Pokemon>, Error>(ResponseModel<Pokemon>.init(cards: nil))

    init(cache: UserCache) {
        self.cache = cache
    }

    public func fetchPokemons() -> AnyPublisher<ResponseModel<[Pokemon]>, Error> {
        let pokemons = Defaults[\.pokemons] ?? [Pokemon(id: "hoop", name: "Yusuf")]
        currentValueFetch.send(ResponseModel<[Pokemon]>.init(cards: pokemons))
        return currentValueFetch.eraseToAnyPublisher()
    }
    
    public func checkFavPokemon(pokemon: Pokemon) -> AnyPublisher<ResponseModel<Domain.Pokemon>, Error> {
        let pokemons = Defaults[\.pokemons] ?? []
        let removedPokemons = pokemons.filter({ $0.id == pokemon.id })
        var newPokemons = pokemons.filter({ $0.id != pokemon.id })
        var changedPokemon = pokemon
        if removedPokemons.isEmpty {
            changedPokemon.isFav = true
            newPokemons.append(pokemon)
            currentValueFav.send(ResponseModel<Pokemon>.init(cards: changedPokemon))
        }
        else {
            changedPokemon.isFav = false
            currentValueFav.send(ResponseModel<Pokemon>.init(cards: changedPokemon))
        }
        Defaults[\.pokemons] = newPokemons
        return currentValueFav.eraseToAnyPublisher()
    }
}
