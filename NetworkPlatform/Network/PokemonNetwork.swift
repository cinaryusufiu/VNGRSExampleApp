//
//  PokemonNetwork.swift
//  NetworkPlatform
//
//  Created by Yusuf Çınar on 16.08.2023.
//

import Domain
import Combine

extension NetworkProvider {

    public func makePostsNetwork() -> PokemonNetwork {
        let network = Network()
        return PokemonNetwork(network: network)
    }
}

public final class PokemonNetwork {

    private let network: Network

    init(network: Network) {
        self.network = network
    }

    public func fetchPokemons(searchText: String?) -> AnyPublisher<ResponseModel<[Pokemon]>, Error> {
        let endPoint = Endpoint(path: "cards")
        endPoint.queryItems.append(URLQueryItem(name: "name", value: searchText))
        return network.request(type: ResponseModel<[Pokemon]>.self, endPoint: endPoint)
    }
    
    public func savePokemon() -> AnyPublisher<ResponseModel<Domain.Pokemon>, Error> {
        let endPoint = Endpoint(path: "save")
        return network.request(type: ResponseModel<Pokemon>.self, endPoint: endPoint)
    }
    
    public func deletePokemon() -> AnyPublisher<ResponseModel<Domain.Pokemon>, Error> {
        let endPoint = Endpoint(path: "delete")
        return network.request(type: ResponseModel<Pokemon>.self, endPoint: endPoint)
    }
}
