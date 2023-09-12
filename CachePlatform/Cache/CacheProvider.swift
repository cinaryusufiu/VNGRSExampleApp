//
//  CacheProvider.swift
//  CachePlatform
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Foundation
import Domain
import Combine

final class CacheProvider { public init() { } }

extension CacheProvider {

    public func makePostsNetwork() -> PokemonCache {
        let cache = UserCache()
        return PokemonCache(cache: cache)
    }
}

public final class PokemonUseCaseProvider: Domain.PokemonUseCaseProvider {
   
    private let cacheProvider: CacheProvider

    public init() {
        cacheProvider = CacheProvider()
    }

    public func makePokemonUseCase() -> Domain.PokemonUseCase {
        return PokemonsUseCase(cache: cacheProvider.makePostsNetwork())
    }
}
