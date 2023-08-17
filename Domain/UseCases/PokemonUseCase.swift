//
//  PokemonUseCase.swift
//  Domain
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation
import Combine

public protocol PokemonUseCase {
    
    func fetchAllPokemons(searchText: String?) -> AnyPublisher<ResponseModel<[Pokemon]>, Error>
    func checkFav(item: Pokemon) -> AnyPublisher<ResponseModel<Pokemon>, Error>
}
