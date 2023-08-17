//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation
import Domain

final class NetworkProvider { public init() { } }

public final class PokemonUseCaseProvider: Domain.PokemonUseCaseProvider {
   
    private let networkProvider: NetworkProvider

    public init() {
        networkProvider = NetworkProvider()
    }

    public func makePokemonUseCase() -> Domain.PokemonUseCase {
        return PokemonsUseCase(network: networkProvider.makePostsNetwork())
    }
}
